// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trending_coin_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TrendingCoinModel _$TrendingCoinModelFromJson(Map<String, dynamic> json) =>
    TrendingCoinModel(
      id: json['id'] as String,
      name: json['name'] as String,
      symbol: json['symbol'] as String,
      thumb: json['thumb'] as String,
      marketCapRank: (json['market_cap_rank'] as num).toInt(),
    );

Map<String, dynamic> _$TrendingCoinModelToJson(TrendingCoinModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'symbol': instance.symbol,
      'thumb': instance.thumb,
      'market_cap_rank': instance.marketCapRank,
    };
