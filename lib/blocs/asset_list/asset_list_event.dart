part of 'asset_list_bloc.dart';

abstract class AssetListEvent extends Equatable {}

class AssetListLoaded extends AssetListEvent {
  @override
  List<Object?> get props => [];
}
