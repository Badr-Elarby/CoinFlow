import 'package:team_7/core/networking/api_result.dart';
import 'package:team_7/features/portfolio/data/datasources/portfolio_remote_data_source.dart';
import 'package:team_7/features/portfolio/data/models/coin_model.dart';
import 'package:team_7/features/portfolio/data/models/portfolio_balance_model.dart';
import 'package:team_7/features/portfolio/data/models/trending_coin_model.dart';
import 'package:team_7/features/portfolio/data/repositories/portfolio_repository.dart';

class PortfolioRepositoryImpl implements PortfolioRepository {
  final PortfolioRemoteDataSource _remoteDataSource;

  // Static holdings configuration (will be replaced with local storage later)
  static const List<Map<String, dynamic>> _userHoldings = [
    {'coinId': 'bitcoin', 'symbol': 'BTC', 'quantity': 0.05},
    {'coinId': 'ethereum', 'symbol': 'ETH', 'quantity': 1.5},
    {'coinId': 'litecoin', 'symbol': 'LTC', 'quantity': 26.3},
  ];

  PortfolioRepositoryImpl(this._remoteDataSource);

  @override
  Future<ApiResult<List<CoinModel>>> fetchPortfolioCoins() async {
    try {
      final coinIds = _userHoldings.map((h) => h['coinId'] as String).toList();
      final coins = await _remoteDataSource.getPortfolioCoins(coinIds: coinIds);
      return ApiResult.success(coins);
    } catch (e) {
      return ApiResult.error(e);
    }
  }

  @override
  Future<ApiResult<PortfolioBalanceModel>> fetchTotalBalance() async {
    try {
      // Get current prices for all holdings using Simple Price Endpoint
      final coinIds = _userHoldings.map((h) => h['coinId'] as String).toList();
      final priceModel = await _remoteDataSource.getSimplePrice(
        coinIds: coinIds,
      );

      // Calculate total value and allocations
      double totalValue = 0;
      double totalDailyChange = 0;
      List<HoldingAllocation> allocations = [];

      for (final holding in _userHoldings) {
        final coinId = holding['coinId'] as String;
        final quantity = holding['quantity'] as double;

        final priceData = priceModel.prices[coinId];
        if (priceData == null) continue;

        final currentPrice = priceData.usd;
        final changePercent = priceData.usd24hChange ?? 0.0;

        final value = quantity * currentPrice;
        final dailyChange = value * (changePercent / 100);

        totalValue += value;
        totalDailyChange += dailyChange;

        allocations.add(
          HoldingAllocation(
            coinId: coinId,
            symbol: holding['symbol'] as String,
            value: value,
            percentage: 0, // Will be calculated after total is known
          ),
        );
      }

      // Calculate percentages
      allocations = allocations.map((allocation) {
        return HoldingAllocation(
          coinId: allocation.coinId,
          symbol: allocation.symbol,
          value: allocation.value,
          percentage: totalValue > 0
              ? ((allocation.value / totalValue) * 100).toDouble()
              : 0.0,
        );
      }).toList();

      final dailyChangePercentage = totalValue > 0
          ? ((totalDailyChange / totalValue) * 100).toDouble()
          : 0.0;

      final balance = PortfolioBalanceModel(
        totalValue: totalValue,
        dailyChange: totalDailyChange,
        dailyChangePercentage: dailyChangePercentage,
        allocations: allocations,
      );

      return ApiResult.success(balance);
    } catch (e) {
      return ApiResult.error(e);
    }
  }

  @override
  Future<ApiResult<List<TrendingCoinModel>>> fetchTrendingCoins() async {
    try {
      final coins = await _remoteDataSource.getTrendingCoins();
      return ApiResult.success(coins);
    } catch (e) {
      return ApiResult.error(e);
    }
  }

  @override
  Future<ApiResult<CoinModel>> getCoinDetails({required String coinId}) async {
    try {
      final coin = await _remoteDataSource.getCoinDetails(coinId: coinId);
      return ApiResult.success(coin);
    } catch (e) {
      return ApiResult.error(e);
    }
  }
}
