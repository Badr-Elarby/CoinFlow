import 'package:json_annotation/json_annotation.dart';

part 'coin_details_model.g.dart';

@JsonSerializable()
class CoinDetailsModel {
  final String? id;
  final String? symbol;
  final String? name;
  @JsonKey(name: 'web_slug')
  final String? webSlug;
  @JsonKey(name: 'block_time_in_minutes')
  final int? blockTimeInMinutes;
  @JsonKey(name: 'hashing_algorithm')
  final String? hashingAlgorithm;
  final List<String>? categories;
  final CoinDescription? description;
  final CoinImage? image;
  @JsonKey(name: 'market_data')
  final MarketData? marketData;
  @JsonKey(name: 'last_updated')
  final String? lastUpdated;

  CoinDetailsModel({
    this.id,
    this.symbol,
    this.name,
    this.webSlug,
    this.blockTimeInMinutes,
    this.hashingAlgorithm,
    this.categories,
    this.description,
    this.image,
    this.marketData,
    this.lastUpdated,
  });

  factory CoinDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$CoinDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$CoinDetailsModelToJson(this);
}

@JsonSerializable()
class CoinDescription {
  final String? en;

  CoinDescription({this.en});

  factory CoinDescription.fromJson(Map<String, dynamic> json) =>
      _$CoinDescriptionFromJson(json);

  Map<String, dynamic> toJson() => _$CoinDescriptionToJson(this);
}

@JsonSerializable()
class CoinImage {
  final String? thumb;
  final String? small;
  final String? large;

  CoinImage({this.thumb, this.small, this.large});

  factory CoinImage.fromJson(Map<String, dynamic> json) =>
      _$CoinImageFromJson(json);

  Map<String, dynamic> toJson() => _$CoinImageToJson(this);
}

@JsonSerializable()
class MarketData {
  @JsonKey(name: 'current_price')
  final Map<String, double>? currentPrice;
  @JsonKey(name: 'market_cap')
  final Map<String, double>? marketCap;
  @JsonKey(name: 'total_volume')
  final Map<String, double>? totalVolume;
  @JsonKey(name: 'high_24h')
  final Map<String, double>? high24h;
  @JsonKey(name: 'low_24h')
  final Map<String, double>? low24h;
  @JsonKey(name: 'price_change_24h')
  final double? priceChange24h;
  @JsonKey(name: 'price_change_percentage_24h')
  final double? priceChangePercentage24h;
  @JsonKey(name: 'price_change_percentage_7d')
  final double? priceChangePercentage7d;
  @JsonKey(name: 'price_change_percentage_30d')
  final double? priceChangePercentage30d;
  @JsonKey(name: 'price_change_percentage_1y')
  final double? priceChangePercentage1y;
  @JsonKey(name: 'market_cap_rank')
  final int? marketCapRank;
  @JsonKey(name: 'circulating_supply')
  final double? circulatingSupply;
  @JsonKey(name: 'total_supply')
  final double? totalSupply;
  @JsonKey(name: 'max_supply')
  final double? maxSupply;
  @JsonKey(name: 'ath')
  final Map<String, double>? ath;
  @JsonKey(name: 'ath_change_percentage')
  final Map<String, double>? athChangePercentage;
  @JsonKey(name: 'atl')
  final Map<String, double>? atl;
  @JsonKey(name: 'sparkline_7d')
  final SparklineData? sparkline7d;

  MarketData({
    this.currentPrice,
    this.marketCap,
    this.totalVolume,
    this.high24h,
    this.low24h,
    this.priceChange24h,
    this.priceChangePercentage24h,
    this.priceChangePercentage7d,
    this.priceChangePercentage30d,
    this.priceChangePercentage1y,
    this.marketCapRank,
    this.circulatingSupply,
    this.totalSupply,
    this.maxSupply,
    this.ath,
    this.athChangePercentage,
    this.atl,
    this.sparkline7d,
  });

  // Helper methods for USD values
  double? get currentPriceUsd => currentPrice?['usd'];
  double? get marketCapUsd => marketCap?['usd'];
  double? get totalVolumeUsd => totalVolume?['usd'];
  double? get high24hUsd => high24h?['usd'];
  double? get low24hUsd => low24h?['usd'];
  double? get athUsd => ath?['usd'];
  double? get atlUsd => atl?['usd'];

  bool get isPriceChangePositive => (priceChangePercentage24h ?? 0) >= 0;

  String get formattedPrice {
    final price = currentPriceUsd;
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
    if (priceChangePercentage24h == null) return '0.0%';
    final prefix = isPriceChangePositive ? '+' : '';
    return '$prefix${priceChangePercentage24h!.toStringAsFixed(1)}%';
  }

  factory MarketData.fromJson(Map<String, dynamic> json) =>
      _$MarketDataFromJson(json);

  Map<String, dynamic> toJson() => _$MarketDataToJson(this);
}

@JsonSerializable()
class SparklineData {
  final List<double>? price;

  SparklineData({this.price});

  factory SparklineData.fromJson(Map<String, dynamic> json) =>
      _$SparklineDataFromJson(json);

  Map<String, dynamic> toJson() => _$SparklineDataToJson(this);
}

