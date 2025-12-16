import 'package:team_7/core/networking/api_constant.dart';
import 'package:team_7/core/networking/api_consumer.dart';
import 'package:team_7/features/coin_details/data/model/coin_details_model.dart';
import 'package:team_7/features/coin_details/data/model/market_chart_response.dart';

abstract class CoinDetailsDataSourceBase {
  Future<CoinDetailsModel> getCoinDetails(String coinId);
  Future<MarketChartResponse> getChartData(String coinId, String days);
}

class CoinDetailsDataSource implements CoinDetailsDataSourceBase {
  final ApiConsumer apiConsumer;

  CoinDetailsDataSource({required this.apiConsumer});

  @override
  Future<MarketChartResponse> getChartData(String coinId, String days) async {
    final response = await apiConsumer.get(
      path: ApiConstants.marketChart(coinId),
      queryParameters: {
        'vs_currency': 'usd',
        'days': days,
      },
    );
    return MarketChartResponse.fromJson(response);
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
        'sparkline': false,
      },
    );
    return CoinDetailsModel.fromJson(response);
  }
}
