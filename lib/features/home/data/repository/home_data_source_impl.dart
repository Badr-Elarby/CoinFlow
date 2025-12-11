import 'package:team_7/core/networking/api_constant.dart';
import 'package:team_7/core/networking/api_consumer.dart';
import 'package:team_7/features/home/data/model/global_data_model.dart';
import 'package:team_7/features/home/data/model/market_coin_model.dart';
import 'package:team_7/features/home/data/model/trending_coin_model.dart';
import 'package:team_7/features/home/domain/repository/home_data_source.dart';

class HomeDataSourceImpl implements HomeDataSource {
  final ApiConsumer apiConsumer;
  HomeDataSourceImpl({required this.apiConsumer});

  @override
  Future<GlobalDataModel> getGlobalData() async {
    final response = await apiConsumer.get(path: ApiConstants.global);
    return GlobalDataModel.fromJson(response['data']);
  }

  @override
  Future<List<MarketCoinModel>> getMarketCoins() async {
    final response = await apiConsumer.get(
      path: ApiConstants.markets,
      queryParameters: {
        'vs_currency': 'usd',
        'order': 'market_cap_desc',
        'per_page': 20,
        'page': 1,
        'sparkline': false,
      },
    );
    return (response as List).map((e) => MarketCoinModel.fromJson(e)).toList();
  }

  @override
  Future<List<TrendingCoinModel>> getTrendingCoins() async {
    final response = await apiConsumer.get(path: ApiConstants.trending);
    final coins = response['coins'] as List;
    return coins.map((e) => TrendingCoinModel.fromJson(e)).toList();
  }
}
