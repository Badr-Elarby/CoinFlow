import 'package:team_7/features/coin_details/data/model/coin_details_model.dart';
import 'package:team_7/features/coin_details/data/model/market_chart_response.dart';
import 'package:team_7/features/coin_details/data/source/coin_details_data_source.dart';
import 'package:team_7/features/coin_details/domain/repository/coin_details_repo.dart';

class CoinRepositoryImpl implements CoinDetailsRepo {
  final CoinDetailsDataSourceBase coinDetailsDataSource;

  CoinRepositoryImpl(this.coinDetailsDataSource);

  @override
  Future<CoinDetailsModel> getCoinDetails(String coinId) async {
    return await coinDetailsDataSource.getCoinDetails(coinId);
  }

  @override
  Future<List<ChartDataPoint>> getChartData(
    String coinId,
    String days,
  ) async {
    final response = await coinDetailsDataSource.getChartData(coinId, days);

    return response.prices.map((point) {
      return ChartDataPoint(
        timestamp: DateTime.fromMillisecondsSinceEpoch(point[0].toInt()),
        price: point[1].toDouble(),
      );
    }).toList();
  }
}