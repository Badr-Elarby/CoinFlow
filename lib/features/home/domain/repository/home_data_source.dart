import 'package:team_7/features/home/data/model/global_data_model.dart';
import 'package:team_7/features/home/data/model/market_coin_model.dart';
import 'package:team_7/features/home/data/model/trending_coin_model.dart';

abstract class HomeDataSource {
  Future<GlobalDataModel> getGlobalData();
  Future<List<MarketCoinModel>> getMarketCoins();
  Future<List<TrendingCoinModel>> getTrendingCoins();
}
