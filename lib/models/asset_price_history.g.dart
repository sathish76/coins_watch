// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset_price_history.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AssetPriceHistory _$AssetPriceHistoryFromJson(Map<String, dynamic> json) =>
    AssetPriceHistory(
      (json['period'] as num?)?.toDouble(),
      (json['open'] as num?)?.toDouble(),
      (json['close'] as num?)?.toDouble(),
      (json['high'] as num?)?.toDouble(),
      (json['low'] as num?)?.toDouble(),
      (json['volume'] as num?)?.toDouble(),
      json['assetId'] as String?,
    );

Map<String, dynamic> _$AssetPriceHistoryToJson(AssetPriceHistory instance) =>
    <String, dynamic>{
      'period': instance.period,
      'assetId': instance.assetId,
      'open': instance.open,
      'close': instance.close,
      'high': instance.high,
      'low': instance.low,
      'volume': instance.volume,
    };

AssetPriceHistoryResponse _$AssetPriceHistoryResponseFromJson(
        Map<String, dynamic> json) =>
    AssetPriceHistoryResponse(
      (json['data'] as List<dynamic>)
          .map((e) => AssetPriceHistory.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AssetPriceHistoryResponseToJson(
        AssetPriceHistoryResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
