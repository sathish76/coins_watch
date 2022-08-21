import 'dart:async';

import 'package:coin_watch/blocs/base_state.dart';
import 'package:coin_watch/data/repository/asset_list_repo.dart';
import 'package:coin_watch/models/asset.dart';
import 'package:coin_watch/utils/response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'asset_list_event.dart';
part 'asset_list_state.dart';

class AssetListBloc extends Bloc<AssetListEvent, AssetListState> {
  final AssetRepository _assetRepository;
  AssetListBloc(this._assetRepository)
      : super(AssetListState(status: BlocStatusEnum.initial)) {
    // Periodically fetching and inserting the new price data into the local db.
    // For every new record insertion,  _assetRepository.getAssetsAndFetchLatest() in Line no: 29 will get latest data reactively
    Timer.periodic(Duration(seconds: 10), (_) async {
      await _assetRepository.fetchAndStoreLatestAssetList();
    });

    // Bloc events
    on<AssetListLoaded>(_onAssetListLoaded);
  }

  Future<void> _onAssetListLoaded(
      AssetListLoaded event, Emitter<AssetListState> emit) async {
    emit(state.copyWith(status: BlocStatusEnum.loading));

    await emit.forEach(_assetRepository.getAssetsAndFetchLatest(),
        onData: (event) {
      if (event is Response<List<Asset>> && event.isSuccess) {
        return state.copyWith(
            status: BlocStatusEnum.success, assets: event.data);
      }
      return state;
    }, onError: (_, __) {
      return state.copyWith(status: BlocStatusEnum.failure);
    });
  }
}
