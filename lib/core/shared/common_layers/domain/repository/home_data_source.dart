import 'package:team_7/core/shared/common_layers/data/model/market_coin_model.dart';
import 'package:team_7/core/shared/common_layers/data/model/search_response.dart';
import 'package:team_7/features/market/data/models/coin_details_model.dart';

abstract class HomeDataSource {
  Future<List<MarketCoinModel>> getMarketCoins();
  Future<SearchResponse> getTrendingCoins();
  Future<CoinDetailsModel> getCoinDetails(String coinId);
  Future<List<List<double>>> getMarketChart(String coinId, {String vsCurrency = 'usd', int days = 7});
}