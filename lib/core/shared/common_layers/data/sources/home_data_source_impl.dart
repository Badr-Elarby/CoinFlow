import 'package:team_7/core/networking/api_constant.dart';
import 'package:team_7/core/networking/api_consumer.dart';
import 'package:team_7/core/shared/common_layers/data/model/market_coin_model.dart';
import 'package:team_7/core/shared/common_layers/data/model/search_response.dart';
import 'package:team_7/core/shared/common_layers/domain/repository/home_data_source.dart';
import 'package:team_7/features/market/data/models/coin_details_model.dart';

class HomeDataSourceImpl implements HomeDataSource {
  final ApiConsumer apiConsumer;

  HomeDataSourceImpl({required this.apiConsumer});

  @override
  Future<List<MarketCoinModel>> getMarketCoins() async {
    final response = await apiConsumer.get(
      path: ApiConstants.markets,
      queryParameters: {
        'vs_currency': 'usd',
        'order': 'market_cap_desc',
        'per_page': 100,
        'page': 1,
        'sparkline': false,
      },
    );
    return (response as List).map((e) => MarketCoinModel.fromJson(e)).toList();
  }

  @override
  Future<SearchResponse> getTrendingCoins() async {
    final response = await apiConsumer.get(path: ApiConstants.trending);
    final coins = response['coins'];
    return coins.map((e) => SearchResponse.fromJson(e));
  }

  @override
  Future<CoinDetailsModel> getCoinDetails(String coinId) async {
    final response = await apiConsumer.get(
      path: ApiConstants.coinDetails(coinId),
      queryParameters: {
        'localization': false,
        'tickers': false,
        'market_data': true,
        'community_data': false,
        'developer_data': false,
        'sparkline': true,
      },
    );
    return CoinDetailsModel.fromJson(response);
  }

  @override
  Future<List<List<double>>> getMarketChart(
    String coinId, {
    String vsCurrency = 'usd',
    int days = 7,
  }) async {
    final response = await apiConsumer.get(
      path: ApiConstants.marketChart(coinId),
      queryParameters: {
        'vs_currency': vsCurrency,
        'days': days,
      },
    );
    final prices = response['prices'] as List;
    return prices.map<List<double>>((e) => 
      (e as List).map<double>((v) => (v as num).toDouble()).toList()
    ).toList();
  }
}
