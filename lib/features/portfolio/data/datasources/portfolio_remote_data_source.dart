import 'package:team_7/features/portfolio/data/models/coin_model.dart';
import 'package:team_7/features/portfolio/data/models/coin_price_model.dart';
import 'package:team_7/features/portfolio/data/models/trending_coin_model.dart';

abstract class PortfolioRemoteDataSource {
  /// Get simple price for coins
  Future<CoinPriceModel> getSimplePrice({required List<String> coinIds});

  /// Get trending coins
  Future<List<TrendingCoinModel>> getTrendingCoins();

  /// Get portfolio coins from CoinGecko API
  /// [coinIds] - List of coin IDs (e.g., ['bitcoin', 'ethereum', 'litecoin'])
  Future<List<CoinModel>> getPortfolioCoins({required List<String> coinIds});

  /// Get single coin details
  Future<CoinModel> getCoinDetails({required String coinId});
}
