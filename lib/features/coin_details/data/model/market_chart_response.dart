import 'package:json_annotation/json_annotation.dart';

part 'market_chart_response.g.dart';

@JsonSerializable()
class MarketChartResponse {
  final List<List<num>> prices;

  MarketChartResponse({required this.prices});

  factory MarketChartResponse.fromJson(Map<String, dynamic> json) =>
      _$MarketChartResponseFromJson(json);
}

class ChartDataPoint {
  final DateTime timestamp;
  final double price;

  ChartDataPoint({
    required this.timestamp,
    required this.price,
  });
}