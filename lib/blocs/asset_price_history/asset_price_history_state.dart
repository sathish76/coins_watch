part of 'asset_price_history_bloc.dart';

class AssetPriceHistoryState extends BaseBlocState {
  final Asset? selectedAsset;
  final BlocStatusEnum? status;
  final List<AssetPriceHistory>? priceHistory;
  final double? maxPrice;
  final double? minPrice;
  final double? startTime;
  final double? endTime;
  final double? yAxisPriceUnit;
  final double? candleStickTimeFrame;

  AssetPriceHistoryState({
    this.maxPrice,
    this.minPrice,
    this.startTime,
    this.endTime,
    this.yAxisPriceUnit,
    this.priceHistory,
    this.status,
    this.selectedAsset,
    this.candleStickTimeFrame,
  }) : super(status);

  AssetPriceHistoryState copyWith(
          {Asset? selectedAsset,
          BlocStatusEnum? status,
          List<AssetPriceHistory>? priceHistory,
          double? maxPrice,
          double? minPrice,
          double? startTime,
          double? endTime,
          double? yAxisPriceUnit,
          double? candleStickTimeFrame}) =>
      AssetPriceHistoryState(
        selectedAsset: selectedAsset ?? this.selectedAsset,
        status: status ?? this.status,
        priceHistory: priceHistory ?? this.priceHistory,
        maxPrice: maxPrice ?? this.maxPrice,
        minPrice: minPrice ?? this.minPrice,
        startTime: startTime ?? this.startTime,
        endTime: endTime ?? this.endTime,
        yAxisPriceUnit: yAxisPriceUnit ?? this.yAxisPriceUnit,
        candleStickTimeFrame: candleStickTimeFrame ?? this.candleStickTimeFrame,
      );

  @override
  List<Object?> get props => [
        maxPrice,
        minPrice,
        startTime,
        endTime,
        yAxisPriceUnit,
        priceHistory,
        status,
        selectedAsset,
        candleStickTimeFrame
      ];

  @override
  bool? get stringify => true;
}
