// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'asset.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Asset _$AssetFromJson(Map<String, dynamic> json) => Asset(
      id: json['id'] as String,
      rank: json['rank'] as int?,
      name: json['name'] as String?,
      symbol: json['symbol'] as String?,
      priceUsd: json['priceUsd'] as String?,
      volumeUsd24Hr: json['volumeUsd24Hr'] as String?,
      changePercent24Hr: json['changePercent24Hr'] as String?,
    );

Map<String, dynamic> _$AssetToJson(Asset instance) => <String, dynamic>{
      'id': instance.id,
      'rank': instance.rank,
      'name': instance.name,
      'symbol': instance.symbol,
      'priceUsd': instance.priceUsd,
      'volumeUsd24Hr': instance.volumeUsd24Hr,
      'changePercent24Hr': instance.changePercent24Hr,
    };

AssetApiResponse _$AssetApiResponseFromJson(Map<String, dynamic> json) =>
    AssetApiResponse(
      (json['data'] as List<dynamic>)
          .map((e) => Asset.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AssetApiResponseToJson(AssetApiResponse instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
