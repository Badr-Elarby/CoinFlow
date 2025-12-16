import 'package:team_7/core/networking/api_result.dart';
import 'package:team_7/core/shared/common_layers/data/model/market_coin_model.dart';
import 'package:team_7/core/shared/common_layers/data/model/search_response.dart';
import 'package:team_7/core/shared/common_layers/domain/repository/home_data_source.dart';
import 'package:team_7/core/shared/common_layers/domain/repository/home_repo.dart';
import 'package:team_7/features/market/data/models/coin_details_model.dart';

class HomeRepoImpl implements HomeRepo {
  final HomeDataSource homeDataSource;

  HomeRepoImpl(this.homeDataSource);

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
  Future<ApiResult<SearchResponse>> getTrendingCoins() async {
    try {
      final response = await homeDataSource.getTrendingCoins();
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(e);
    }
  }

  @override
  Future<ApiResult<CoinDetailsModel>> getCoinDetails(String coinId) async {
    try {
      final response = await homeDataSource.getCoinDetails(coinId);
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(e);
    }
  }

  @override
  Future<ApiResult<List<List<double>>>> getMarketChart(
    String coinId, {
    String vsCurrency = 'usd',
    int days = 7,
  }) async {
    try {
      final response = await homeDataSource.getMarketChart(
        coinId,
        vsCurrency: vsCurrency,
        days: days,
      );
      return ApiResult.success(response);
    } catch (e) {
      return ApiResult.error(e);
    }
  }
}
