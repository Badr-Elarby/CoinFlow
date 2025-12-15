import 'package:team_7/core/networking/api_result.dart';
import 'package:team_7/features/portfolio/data/models/coin_model.dart';
import 'package:team_7/features/portfolio/data/models/portfolio_balance_model.dart';
import 'package:team_7/features/portfolio/data/models/trending_coin_model.dart';

abstract class PortfolioRepository {
  /// Fetch portfolio coins with their current prices
  Future<ApiResult<List<CoinModel>>> fetchPortfolioCoins();

  /// Calculate and fetch total portfolio balance
  Future<ApiResult<PortfolioBalanceModel>> fetchTotalBalance();

  /// Get trending coins
  Future<ApiResult<List<TrendingCoinModel>>> fetchTrendingCoins();

  /// Get specific coin details
  Future<ApiResult<CoinModel>> getCoinDetails({required String coinId});
}
