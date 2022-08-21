import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:coin_watch/utils/extensions.dart';

part 'asset.g.dart';

@JsonSerializable()
@entity
class Asset extends Equatable {
  @primaryKey
  final String id;
  final int? rank;
  final String? name;
  final String? symbol;
  final String? priceUsd;
  final String? volumeUsd24Hr;
  final String? changePercent24Hr;

  const Asset(
      {required this.id, this.rank, this.name, this.symbol, this.priceUsd, this.volumeUsd24Hr, this.changePercent24Hr});

  factory Asset.fromJson(Map<String, dynamic> json) {
    json['rank'] = int.parse(json['rank']);
    json['priceUsd'] = double.parse((json['priceUsd'] as String)).toStringAsFixed(2);
    json['volumeUsd24Hr'] = (json['volumeUsd24Hr'] as String?)?.readablePrice;
    json['changePercent24Hr'] = (json['changePercent24Hr'] as String?)?.readablePercentage;
    return _$AssetFromJson(json);
  }
  Map<String, dynamic> toJson() => _$AssetToJson(this);

  @override
  List<Object?> get props => [id, rank, name, symbol, priceUsd, volumeUsd24Hr, changePercent24Hr];
}

@JsonSerializable()
class AssetApiResponse extends Equatable {
  final List<Asset> data;

  AssetApiResponse(this.data);

  factory AssetApiResponse.fromJson(Map<String, dynamic> json) => _$AssetApiResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AssetApiResponseToJson(this);

  @override
  List<Object?> get props => [data];
}
