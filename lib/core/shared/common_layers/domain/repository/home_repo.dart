import 'package:team_7/core/networking/api_result.dart';
import 'package:team_7/core/shared/common_layers/data/model/market_coin_model.dart';
import 'package:team_7/core/shared/common_layers/data/model/search_response.dart';
import 'package:team_7/features/market/data/models/coin_details_model.dart';

abstract class HomeRepo {
  Future<ApiResult<List<MarketCoinModel>>> getMarketCoins();
  Future<ApiResult<SearchResponse>> getTrendingCoins();
  Future<ApiResult<CoinDetailsModel>> getCoinDetails(String coinId);
  Future<ApiResult<List<List<double>>>> getMarketChart(String coinId, {String vsCurrency = 'usd', int days = 7});
}