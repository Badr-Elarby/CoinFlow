import 'package:team_7/features/coin_details/data/model/coin_details_model.dart';
import 'package:team_7/features/coin_details/data/model/market_chart_response.dart';

abstract class CoinDetailsRepo {
  Future<CoinDetailsModel> getCoinDetails(String coinId);

  Future<List<ChartDataPoint>> getChartData(String coinId, String days);
}
