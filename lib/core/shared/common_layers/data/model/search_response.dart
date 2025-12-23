import 'package:json_annotation/json_annotation.dart';
import 'package:team_7/core/shared/common_layers/data/model/trending_coin_model.dart';

part 'search_response.g.dart';

@JsonSerializable()
class SearchResponse {
  final List<TrendingCoinModel> coins;

  const SearchResponse({
    required this.coins,
  });

  factory SearchResponse.fromJson(Map<String, dynamic> json) =>
      _$SearchResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SearchResponseToJson(this);
}