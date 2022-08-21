part of 'asset_price_history_bloc.dart';

abstract class AssetPriceHistoryEvent extends Equatable {}

class AssetPriceHistoryLoaded extends AssetPriceHistoryEvent {
  final Asset? selectedAsset;
  AssetPriceHistoryLoaded(this.selectedAsset);

  @override
  List<Object?> get props => [selectedAsset];
}
