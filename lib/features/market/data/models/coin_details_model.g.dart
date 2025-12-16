// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'coin_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CoinDetailsModel _$CoinDetailsModelFromJson(Map<String, dynamic> json) =>
    CoinDetailsModel(
      id: json['id'] as String?,
      symbol: json['symbol'] as String?,
      name: json['name'] as String?,
      webSlug: json['web_slug'] as String?,
      blockTimeInMinutes: (json['block_time_in_minutes'] as num?)?.toInt(),
      hashingAlgorithm: json['hashing_algorithm'] as String?,
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      description: json['description'] == null
          ? null
          : CoinDescription.fromJson(
              json['description'] as Map<String, dynamic>),
      image: json['image'] == null
          ? null
          : CoinImage.fromJson(json['image'] as Map<String, dynamic>),
      marketData: json['market_data'] == null
          ? null
          : MarketData.fromJson(json['market_data'] as Map<String, dynamic>),
      lastUpdated: json['last_updated'] as String?,
    );

Map<String, dynamic> _$CoinDetailsModelToJson(CoinDetailsModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'symbol': instance.symbol,
      'name': instance.name,
      'web_slug': instance.webSlug,
      'block_time_in_minutes': instance.blockTimeInMinutes,
      'hashing_algorithm': instance.hashingAlgorithm,
      'categories': instance.categories,
      'description': instance.description,
      'image': instance.image,
      'market_data': instance.marketData,
      'last_updated': instance.lastUpdated,
    };

CoinDescription _$CoinDescriptionFromJson(Map<String, dynamic> json) =>
    CoinDescription(
      en: json['en'] as String?,
    );

Map<String, dynamic> _$CoinDescriptionToJson(CoinDescription instance) =>
    <String, dynamic>{
      'en': instance.en,
    };

CoinImage _$CoinImageFromJson(Map<String, dynamic> json) => CoinImage(
      thumb: json['thumb'] as String?,
      small: json['small'] as String?,
      large: json['large'] as String?,
    );

Map<String, dynamic> _$CoinImageToJson(CoinImage instance) => <String, dynamic>{
      'thumb': instance.thumb,
      'small': instance.small,
      'large': instance.large,
    };

MarketData _$MarketDataFromJson(Map<String, dynamic> json) => MarketData(
      currentPrice: (json['current_price'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      marketCap: (json['market_cap'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      totalVolume: (json['total_volume'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      high24h: (json['high_24h'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      low24h: (json['low_24h'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      priceChange24h: (json['price_change_24h'] as num?)?.toDouble(),
      priceChangePercentage24h:
          (json['price_change_percentage_24h'] as num?)?.toDouble(),
      priceChangePercentage7d:
          (json['price_change_percentage_7d'] as num?)?.toDouble(),
      priceChangePercentage30d:
          (json['price_change_percentage_30d'] as num?)?.toDouble(),
      priceChangePercentage1y:
          (json['price_change_percentage_1y'] as num?)?.toDouble(),
      marketCapRank: (json['market_cap_rank'] as num?)?.toInt(),
      circulatingSupply: (json['circulating_supply'] as num?)?.toDouble(),
      totalSupply: (json['total_supply'] as num?)?.toDouble(),
      maxSupply: (json['max_supply'] as num?)?.toDouble(),
      ath: (json['ath'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      athChangePercentage:
          (json['ath_change_percentage'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      atl: (json['atl'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
      sparkline7d: json['sparkline_7d'] == null
          ? null
          : SparklineData.fromJson(
              json['sparkline_7d'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$MarketDataToJson(MarketData instance) =>
    <String, dynamic>{
      'current_price': instance.currentPrice,
      'market_cap': instance.marketCap,
      'total_volume': instance.totalVolume,
      'high_24h': instance.high24h,
      'low_24h': instance.low24h,
      'price_change_24h': instance.priceChange24h,
      'price_change_percentage_24h': instance.priceChangePercentage24h,
      'price_change_percentage_7d': instance.priceChangePercentage7d,
      'price_change_percentage_30d': instance.priceChangePercentage30d,
      'price_change_percentage_1y': instance.priceChangePercentage1y,
      'market_cap_rank': instance.marketCapRank,
      'circulating_supply': instance.circulatingSupply,
      'total_supply': instance.totalSupply,
      'max_supply': instance.maxSupply,
      'ath': instance.ath,
      'ath_change_percentage': instance.athChangePercentage,
      'atl': instance.atl,
      'sparkline_7d': instance.sparkline7d,
    };

SparklineData _$SparklineDataFromJson(Map<String, dynamic> json) =>
    SparklineData(
      price: (json['price'] as List<dynamic>?)
          ?.map((e) => (e as num).toDouble())
          .toList(),
    );

Map<String, dynamic> _$SparklineDataToJson(SparklineData instance) =>
    <String, dynamic>{
      'price': instance.price,
    };
