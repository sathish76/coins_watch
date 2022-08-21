import 'dart:async';
import 'package:coin_watch/data/asset_price_history/asset_price_history_dao.dart';
import 'package:coin_watch/data/assets/assets_dao.dart';
import 'package:coin_watch/models/asset.dart';
import 'package:coin_watch/models/asset_price_history.dart';
import 'package:floor/floor.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'database.g.dart'; // the generated code will be there

@Database(version: 1, entities: [Asset, AssetPriceHistory])
abstract class AppDatabase extends FloorDatabase {
  AssetsDao get assetDao;
  AssetPriceHistoryDao get assetPriceHistoryDao;
}
