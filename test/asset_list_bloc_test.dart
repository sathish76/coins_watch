import 'dart:async';

import 'package:bloc_test/bloc_test.dart';
import 'package:coin_watch/blocs/asset_price_history/asset_price_history_bloc.dart';
import 'package:coin_watch/blocs/base_state.dart';
import 'package:coin_watch/data/repository/asset_list_repo.dart';
import 'package:coin_watch/models/asset.dart';
import 'package:coin_watch/models/asset_price_history.dart';
import 'package:coin_watch/utils/response.dart';
import 'package:mockito/mockito.dart';
import 'package:test/test.dart';

class AssetRepositoryMock extends Mock implements AssetRepository {
  @override
  Stream<Response<List<AssetPriceHistory>>> getAssetPriceHistory(
      String assetId, int startTime, int endTime) {
    StreamController<Response<List<AssetPriceHistory>>> stream =
        StreamController<Response<List<AssetPriceHistory>>>();

    stream.add(Response.success(
        data: [mockPriceHistory1, mockPriceHistory2, mockPriceHistory3]));
    return stream.stream;
  }
}

final mockAsset = Asset(id: 'bitcoin');
final mockPriceHistory1 = AssetPriceHistory(11, 5, 9, 13, 3, 110, mockAsset.id);
final mockPriceHistory2 = AssetPriceHistory(15, 4, 10, 5, 4, 130, mockAsset.id);
final mockPriceHistory3 = AssetPriceHistory(12, 5, 11, 7, 6, 90, mockAsset.id);

void main() {
  group('AssetListBloc', () {
    AssetRepository _assetRepository = AssetRepositoryMock();

    setUp(() {
      _assetRepository = AssetRepositoryMock();
    });

    blocTest(
      'emits [] when nothing is added',
      build: () => AssetPriceHistoryBloc(_assetRepository),
      act: (AssetPriceHistoryBloc bloc) {
        return bloc..add(AssetPriceHistoryLoaded(mockAsset));
      },
      expect: () => [
        AssetPriceHistoryState(
          status: BlocStatusEnum.loading,
          selectedAsset: mockAsset,
        ),
        AssetPriceHistoryState(
          status: BlocStatusEnum.success,
          selectedAsset: mockAsset,
          maxPrice: 11.11,
          minPrice: 8.91,
          candleStickTimeFrame: 4.0,
          endTime: 12.0,
          startTime: 11.0,
          yAxisPriceUnit: 0.11109999999999999,
          priceHistory: [
            mockPriceHistory1,
            mockPriceHistory2,
            mockPriceHistory3
          ],
        ),
      ],
    );
  });
}
