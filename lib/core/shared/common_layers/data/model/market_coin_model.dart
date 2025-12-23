import 'package:json_annotation/json_annotation.dart';

part 'market_coin_model.g.dart';

@JsonSerializable()
class MarketCoinModel {
  final String? id;
  final String? name;
  final String? symbol;
  final String? image;
  @JsonKey(name: 'current_price')
  final double? currentPrice;
  @JsonKey(name: "market_cap_rank")
  final int? marketCapRank;
  @JsonKey(name: 'price_change_percentage_24h')
  final double? priceChangePercentage24h;

  MarketCoinModel({
    required this.id,
    required this.name,
    required this.symbol,
    required this.image,
    required this.currentPrice,
    required this.marketCapRank,
    required this.priceChangePercentage24h,
  });

  factory MarketCoinModel.fromJson(Map<String, dynamic> json) =>
      _$MarketCoinModelFromJson(json);

  Map<String, dynamic> toJson() => _$MarketCoinModelToJson(this);

  String get formattedPrice {
    if (currentPrice == null) return '\$0.00';
    if (currentPrice! >= 1000) {
      return '\$${currentPrice!.toStringAsFixed(2).replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},',
          )}';
    }
    return '\$${currentPrice!.toStringAsFixed(currentPrice! < 1 ? 4 : 2)}';
  }
  bool get isPriceChangePositive => (priceChangePercentage24h ?? 0) >= 0;

  String get formattedPriceChange {
    if (priceChangePercentage24h == null) return '0.0%';
    final prefix = isPriceChangePositive ? '+' : '';
    return '$prefix${priceChangePercentage24h!.toStringAsFixed(1)}%';
  }
}