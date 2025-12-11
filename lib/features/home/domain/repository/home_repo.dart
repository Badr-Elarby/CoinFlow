import 'package:team_7/core/networking/api_result.dart';
import 'package:team_7/features/home/data/model/global_data_model.dart';
import 'package:team_7/features/home/data/model/market_coin_model.dart';
import 'package:team_7/features/home/data/model/trending_coin_model.dart';

abstract class HomeRepo {
  Future<ApiResult<GlobalDataModel>> getGlobalData();
  Future<ApiResult<List<MarketCoinModel>>> getMarketCoins();
  Future<ApiResult<List<TrendingCoinModel>>> getTrendingCoins();
}
