// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'market_chart_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MarketChartResponse _$MarketChartResponseFromJson(Map<String, dynamic> json) =>
    MarketChartResponse(
      prices: (json['prices'] as List<dynamic>)
          .map((e) => (e as List<dynamic>).map((e) => e as num).toList())
          .toList(),
    );
