import 'package:json_annotation/json_annotation.dart';

part 'coin_details_model.g.dart';

@JsonSerializable()
class CoinDetailsModel {
  final String id;
  final String name;
  final String symbol;

  @JsonKey(readValue: _readImage)
  final String? image;

  @JsonKey(readValue: _readCurrentPrice)
  final double? currentPrice;

  @JsonKey(readValue: _readPriceChange)
  final double? priceChange24h;

  @JsonKey(readValue: _readMarketCap)
  final double? marketCap;

  @JsonKey(readValue: _readVolume)
  final double? volume24h;

  @JsonKey(readValue: _readCirculatingSupply)
  final double? circulatingSupply;

  @JsonKey(readValue: _readMaxSupply)
  final double? maxSupply;

  @JsonKey(readValue: _readDescription)
  final String? description;

  CoinDetailsModel({
    required this.id,
    required this.name,
    required this.symbol,
    this.image,
    this.currentPrice,
    this.priceChange24h,
    this.marketCap,
    this.volume24h,
    this.circulatingSupply,
    this.maxSupply,
    this.description,
  });

  factory CoinDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$CoinDetailsModelFromJson(json);

  // Helper getters
  bool get isPriceChangePositive => (priceChange24h ?? 0) >= 0;

  String get formattedPrice {
    final price = currentPrice;
    if (price == null) return '\$0.00';
    if (price >= 1000) {
      return '\$${price.toStringAsFixed(2).replaceAllMapped(
            RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
            (Match m) => '${m[1]},',
          )}';
    }
    return '\$${price.toStringAsFixed(price < 1 ? 4 : 2)}';
  }

  String get formattedPriceChange {
    if (priceChange24h == null) return '0.0%';
    final prefix = isPriceChangePositive ? '+' : '';
    return '$prefix${priceChange24h!.toStringAsFixed(2)}%';
  }

  // --------- Custom JSON extractors ----------
  static Object? _readImage(Map map, String key) =>
      map['image']?['large'];

  static Object? _readCurrentPrice(Map map, String key) =>
      map['market_data']?['current_price']?['usd'];

  static Object? _readPriceChange(Map map, String key) =>
      map['market_data']?['price_change_percentage_24h'];

  static Object? _readMarketCap(Map map, String key) =>
      map['market_data']?['market_cap']?['usd'];

  static Object? _readVolume(Map map, String key) =>
      map['market_data']?['total_volume']?['usd'];

  static Object? _readCirculatingSupply(Map map, String key) =>
      map['market_data']?['circulating_supply'];

  static Object? _readMaxSupply(Map map, String key) =>
      map['market_data']?['max_supply'];

  static Object? _readDescription(Map map, String key) =>
      map['description']?['en'];
}