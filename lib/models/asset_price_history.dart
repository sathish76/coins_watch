import 'package:equatable/equatable.dart';
import 'package:floor/floor.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:coin_watch/utils/extensions.dart';

part 'asset_price_history.g.dart';

@JsonSerializable()
@entity
class AssetPriceHistory extends Equatable {
  @primaryKey
  final double? period;
  final String? assetId;
  final double? open;
  final double? close;
  final double? high;
  final double? low;
  final double? volume;

  AssetPriceHistory(this.period, this.open, this.close, this.high, this.low, this.volume, this.assetId);

  factory AssetPriceHistory.fromJson(Map<String, dynamic> json) {
    json['period'] = (json['period'] as int).toDouble();
    json['open'] = double.parse(json['open'] as String).toPrecision(2);
    json['close'] = double.parse(json['close'] as String).toPrecision(2);
    json['high'] = double.parse(json['high'] as String).toPrecision(2);
    json['low'] = double.parse(json['low'] as String).toPrecision(2);
    json['volume'] = double.parse(json['volume'] as String).toPrecision(2);
    return _$AssetPriceHistoryFromJson(json);
  }
  Map<String, dynamic> toJson() => _$AssetPriceHistoryToJson(this);

  AssetPriceHistory setAssetId(String aid) => AssetPriceHistory(period, open, close, high, low, volume, aid);

  @override
  List<Object?> get props => [period, open, close, high, low, volume, assetId];
}

@JsonSerializable()
class AssetPriceHistoryResponse extends Equatable {
  final List<AssetPriceHistory> data;

  AssetPriceHistoryResponse(this.data);

  factory AssetPriceHistoryResponse.fromJson(Map<String, dynamic> json) => _$AssetPriceHistoryResponseFromJson(json);
  Map<String, dynamic> toJson() => _$AssetPriceHistoryResponseToJson(this);

  @override
  List<Object?> get props => [data];
}
