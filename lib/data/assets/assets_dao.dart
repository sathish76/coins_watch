import 'package:coin_watch/models/asset.dart';
import 'package:floor/floor.dart';

@dao
abstract class AssetsDao {
  @Query('SELECT * FROM Asset ORDER BY rank ASC')
  Stream<List<Asset>> getAllAssets();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insertAssets(List<Asset> assets);
}
