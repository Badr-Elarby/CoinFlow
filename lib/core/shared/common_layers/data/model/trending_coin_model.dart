import 'package:json_annotation/json_annotation.dart';

part 'trending_coin_model.g.dart';

@JsonSerializable()
class TrendingCoinModel {
  final String id;
  final String name;
  final String symbol;
  final String thumb;

  @JsonKey(name: 'market_cap_rank')
  final int marketCapRank;

  const TrendingCoinModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.thumb,
    required this.marketCapRank,
  });

  factory TrendingCoinModel.fromJson(Map<String, dynamic> json) =>
      _$TrendingCoinModelFromJson(json);

  Map<String, dynamic> toJson() => _$TrendingCoinModelToJson(this);
}