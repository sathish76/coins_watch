import 'package:coin_watch/models/asset_price_history.dart';
import 'package:floor/floor.dart';

@dao
abstract class AssetPriceHistoryDao {
  @Query('SELECT * FROM AssetPriceHistory WHERE assetId = :assetId ORDER BY period ASC ')
  Stream<List<AssetPriceHistory>> getAssetPriceHistory(String assetId);

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertPriceHistory(List<AssetPriceHistory> priceHistory);
}
