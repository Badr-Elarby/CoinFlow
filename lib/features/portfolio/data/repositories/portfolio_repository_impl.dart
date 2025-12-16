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

      // First pass: Calculate totals and prepare allocation data
      double totalValue = 0;
      double totalDailyChange = 0;
      final allocationData = <Map<String, dynamic>>[];

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

        allocationData.add({
          'coinId': coinId,
          'symbol': holding['symbol'] as String,
          'value': value,
        });
      }

      // Second pass: Build final allocations with calculated percentages
      final allocations = allocationData.map((data) {
        return HoldingAllocation(
          coinId: data['coinId'] as String,
          symbol: data['symbol'] as String,
          value: data['value'] as double,
          percentage: totalValue > 0
              ? (((data['value'] as double) / totalValue) * 100)
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
