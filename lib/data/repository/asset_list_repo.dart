import 'package:coin_watch/data/asset_price_history/asset_price_history_dao.dart';
import 'package:coin_watch/data/asset_price_history/assets_price_history_remote_data_store.dart';
import 'package:coin_watch/data/assets/assets_dao.dart';
import 'package:coin_watch/data/assets/assets_remote_data_store.dart';
import 'package:coin_watch/models/asset.dart';
import 'package:coin_watch/models/asset_price_history.dart';
import 'package:coin_watch/utils/response.dart';
import 'package:coin_watch/utils/single_source_of_truth.dart';
import 'package:injectable/injectable.dart';

abstract class AssetRepository {
  Stream<Response<List<Asset>>> getAssetsAndFetchLatest();
  Future<void> fetchAndStoreLatestAssetList();
  Stream<Response<List<AssetPriceHistory>>> getAssetPriceHistory(
      String assetId, int startTime, int endTime);
}

@Injectable(as: AssetRepository)
class AssetRepositoryImpl implements AssetRepository {
  final AssetsDao _assetsDao;
  final AssetPriceHistoryDao _assetPriceHistoryDao;
  final AssetsRemoteDataStore _assetsRemoteDataStore;
  final AssetsPriceHistoryRemoteDataStore _assetsPriceHistoryRemoteDataStore;

  AssetRepositoryImpl(this._assetsDao, this._assetsRemoteDataStore,
      this._assetPriceHistoryDao, this._assetsPriceHistoryRemoteDataStore);

  @override
  Stream<Response<List<Asset>>> getAssetsAndFetchLatest() {
    return SingleSourceOfTruth<List<Asset>, AssetApiResponse>().asStream(
      dbQuery: _assetsDao.getAllAssets,
      remoteCall: _assetsRemoteDataStore.getAssets,
      mapApiResponseToDbRecord: ((AssetApiResponse result) => result.data),
      saveToDb: _assetsDao.insertAssets,
    );
  }

  @override
  Stream<Response<List<AssetPriceHistory>>> getAssetPriceHistory(
      String assetId, int startTime, int endTime) {
    return SingleSourceOfTruth<List<AssetPriceHistory>,
            AssetPriceHistoryResponse>()
        .asStream(
      dbQuery: () => _assetPriceHistoryDao.getAssetPriceHistory(assetId),
      remoteCall: () => _assetsPriceHistoryRemoteDataStore.getAssetPriceHistory(
        assetId,
        'h1',
        startTime,
        endTime,
      ),
      mapApiResponseToDbRecord: (AssetPriceHistoryResponse result) =>
          result.data.map((e) {
        return e.setAssetId(assetId);
      }).toList(),
      saveToDb: _assetPriceHistoryDao.insertPriceHistory,
    );
  }
  
  Future<void> fetchAndStoreLatestAssetList() async {
    final latestData = await _assetsRemoteDataStore.getAssets();
    await _assetsDao.insertAssets(latestData.data);
  }
}
