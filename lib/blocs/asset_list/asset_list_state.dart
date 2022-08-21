part of 'asset_list_bloc.dart';

class AssetListState extends BaseBlocState {
  final List<Asset>? assets;
  final BlocStatusEnum? status;

  AssetListState({
    this.status,
    this.assets,
  }) : super(status);

  AssetListState copyWith({
    BlocStatusEnum? status,
    List<Asset>? assets,
  }) =>
      AssetListState(status: status ?? this.status, assets: assets ?? this.assets);

  @override
  List<Object?> get props => [status, assets];

  @override
  bool? get stringify => true;
}
