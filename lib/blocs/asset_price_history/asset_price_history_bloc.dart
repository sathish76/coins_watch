import 'dart:async';

import 'package:coin_watch/blocs/base_state.dart';
import 'package:coin_watch/data/repository/asset_list_repo.dart';
import 'package:coin_watch/models/asset.dart';
import 'package:coin_watch/models/asset_price_history.dart';
import 'package:coin_watch/utils/extensions.dart';
import 'package:coin_watch/utils/response.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'asset_price_history_event.dart';
part 'asset_price_history_state.dart';

class AssetPriceHistoryBloc extends Bloc<AssetPriceHistoryEvent, AssetPriceHistoryState> {
  final AssetRepository _assetRepository;
  AssetPriceHistoryBloc(this._assetRepository) : super(AssetPriceHistoryState(status: BlocStatusEnum.initial)) {
    on<AssetPriceHistoryLoaded>(_onAssetListLoaded);
  }

  Future<void> _onAssetListLoaded(AssetPriceHistoryLoaded event, Emitter<AssetPriceHistoryState> emit) async {
    emit(state.copyWith(status: BlocStatusEnum.loading, selectedAsset: event.selectedAsset));
    final now = DateTime.now();
    await emit.forEach(
        _assetRepository.getAssetPriceHistory(
          event.selectedAsset!.id,
          now.startOfTheDayUtcEpoch,
          now.toUtc().millisecondsSinceEpoch,
        ), onData: (event) {
      if (event is Response<List<AssetPriceHistory>> && event.isSuccess && (event.data?.isNotEmpty ?? false)) {
        final List<AssetPriceHistory> priceHistory = event.data!;

        // Find chart's max and min time-frame
        final firstCandleStartTime = priceHistory.first.period!;
        final lastCandleTime = priceHistory.last.period!;
        
        final secondCandleTime = priceHistory[1].period!;
        // by finding difference b/w first and second candle we can calculate time-frame of single candle
        final double candleStickTimeFrame = secondCandleTime - firstCandleStartTime;

        // Find min & max price to plot Chart
        final tempList = List<AssetPriceHistory>.from(priceHistory);
        tempList.sort((AssetPriceHistory u1, AssetPriceHistory u2) => u2.close!.toInt() - u1.close!.toInt());

        double maxPrice = tempList.first.close!;
        maxPrice = maxPrice + (maxPrice * 0.01);
        double minPrice = tempList.last.close!;
        minPrice = minPrice - (minPrice * 0.01);

        // Wild logic: taking 1% of max price to get y axis unit
        double yAxisPriceUnit = maxPrice * 0.01;

        return state.copyWith(
            status: BlocStatusEnum.success,
            priceHistory: event.data,
            maxPrice: maxPrice,
            minPrice: minPrice,
            startTime: firstCandleStartTime,
            endTime: lastCandleTime,
            yAxisPriceUnit: yAxisPriceUnit,
            candleStickTimeFrame: candleStickTimeFrame);
      }
      return state;
    }, onError: (_, __) {
      return state.copyWith(status: BlocStatusEnum.failure);
    });
  }
}
