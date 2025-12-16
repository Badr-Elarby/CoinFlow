import 'package:dio/dio.dart';
import 'package:team_7/core/networking/api_constant.dart';
import 'package:team_7/features/portfolio/data/datasources/portfolio_remote_data_source.dart';
import 'package:team_7/features/portfolio/data/models/coin_model.dart';
import 'package:team_7/features/portfolio/data/models/coin_price_model.dart';
import 'package:team_7/features/portfolio/data/models/trending_coin_model.dart';

class PortfolioRemoteDataSourceImpl implements PortfolioRemoteDataSource {
  final Dio _dio;

  PortfolioRemoteDataSourceImpl(this._dio);

  @override
  Future<CoinPriceModel> getSimplePrice({required List<String> coinIds}) async {
    final response = await _dio.get(
      '${ApiConstants.baseUrl}simple/price',
      queryParameters: {
        'ids': coinIds.join(','),
        'vs_currencies': 'usd',
        'include_24hr_change': 'true',
      },
    );

    return CoinPriceModel.fromJson(response.data);
  }

  @override
  Future<List<TrendingCoinModel>> getTrendingCoins() async {
    final response = await _dio.get('${ApiConstants.baseUrl}search/trending');

    final List coins = response.data['coins'];
    return coins.map((json) => TrendingCoinModel.fromJson(json)).toList();
  }

  @override
  Future<List<CoinModel>> getPortfolioCoins({
    required List<String> coinIds,
  }) async {
    final response = await _dio.get(
      '${ApiConstants.baseUrl}coins/markets',
      queryParameters: {
        'vs_currency': 'usd',
        'ids': coinIds.join(','),
        'order': 'market_cap_desc',
        'per_page': coinIds.length,
        'page': 1,
        'sparkline': false,
        'price_change_percentage': '24h',
      },
    );

    // Dio validates status 200 OK by default
    final List<dynamic> data = response.data;
    return data.map((json) => CoinModel.fromJson(json)).toList();
  }

  @override
  Future<CoinModel> getCoinDetails({required String coinId}) async {
    final response = await _dio.get(
      '${ApiConstants.baseUrl}coins/markets',
      queryParameters: {
        'vs_currency': 'usd',
        'ids': coinId,
        'order': 'market_cap_desc',
        'per_page': 1,
        'page': 1,
        'sparkline': false,
        'price_change_percentage': '24h',
      },
    );

    final List<dynamic> data = response.data;
    // If empty, accessing .first will throw RangeError
    // UnifiedErrorHandler will convert it to ApiErrorModel
    return CoinModel.fromJson(data.first);
  }
}
