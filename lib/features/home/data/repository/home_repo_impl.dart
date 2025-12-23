import 'package:team_7/core/networking/api_result.dart';
import 'package:team_7/features/home/data/model/global_data_model.dart';
import 'package:team_7/features/home/data/model/market_coin_model.dart';
import 'package:team_7/features/home/data/model/trending_coin_model.dart';
import 'package:team_7/features/home/domain/repository/home_data_source.dart';
import 'package:team_7/features/home/domain/repository/home_repo.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeDataSource homeDataSource;
  HomeRepoImpl(this.homeDataSource);

  @override
  Future<ApiResult<GlobalDataModel>> getGlobalData() async {
    try {
      final response = await homeDataSource.getGlobalData();
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(e);
    }
  }

  @override
  Future<ApiResult<List<MarketCoinModel>>> getMarketCoins() async {
    try {
      final response = await homeDataSource.getMarketCoins();
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(e);
    }
  }

  @override
  Future<ApiResult<List<TrendingCoinModel>>> getTrendingCoins() async {
    try {
      final response = await homeDataSource.getTrendingCoins();
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(e);
    }
  }
}
