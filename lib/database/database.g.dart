// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  AssetsDao? _assetDaoInstance;

  AssetPriceHistoryDao? _assetPriceHistoryDaoInstance;

  Future<sqflite.Database> open(String path, List<Migration> migrations,
      [Callback? callback]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Asset` (`id` TEXT NOT NULL, `rank` INTEGER, `name` TEXT, `symbol` TEXT, `priceUsd` TEXT, `volumeUsd24Hr` TEXT, `changePercent24Hr` TEXT, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `AssetPriceHistory` (`period` REAL, `assetId` TEXT, `open` REAL, `close` REAL, `high` REAL, `low` REAL, `volume` REAL, PRIMARY KEY (`period`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  AssetsDao get assetDao {
    return _assetDaoInstance ??= _$AssetsDao(database, changeListener);
  }

  @override
  AssetPriceHistoryDao get assetPriceHistoryDao {
    return _assetPriceHistoryDaoInstance ??=
        _$AssetPriceHistoryDao(database, changeListener);
  }
}

class _$AssetsDao extends AssetsDao {
  _$AssetsDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _assetInsertionAdapter = InsertionAdapter(
            database,
            'Asset',
            (Asset item) => <String, Object?>{
                  'id': item.id,
                  'rank': item.rank,
                  'name': item.name,
                  'symbol': item.symbol,
                  'priceUsd': item.priceUsd,
                  'volumeUsd24Hr': item.volumeUsd24Hr,
                  'changePercent24Hr': item.changePercent24Hr
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Asset> _assetInsertionAdapter;

  @override
  Stream<List<Asset>> getAllAssets() {
    return _queryAdapter.queryListStream(
        'SELECT * FROM Asset ORDER BY rank ASC',
        mapper: (Map<String, Object?> row) => Asset(
            id: row['id'] as String,
            rank: row['rank'] as int?,
            name: row['name'] as String?,
            symbol: row['symbol'] as String?,
            priceUsd: row['priceUsd'] as String?,
            volumeUsd24Hr: row['volumeUsd24Hr'] as String?,
            changePercent24Hr: row['changePercent24Hr'] as String?),
        queryableName: 'Asset',
        isView: false);
  }

  @override
  Future<void> insertAssets(List<Asset> assets) async {
    await _assetInsertionAdapter.insertList(assets, OnConflictStrategy.replace);
  }
}

class _$AssetPriceHistoryDao extends AssetPriceHistoryDao {
  _$AssetPriceHistoryDao(this.database, this.changeListener)
      : _queryAdapter = QueryAdapter(database, changeListener),
        _assetPriceHistoryInsertionAdapter = InsertionAdapter(
            database,
            'AssetPriceHistory',
            (AssetPriceHistory item) => <String, Object?>{
                  'period': item.period,
                  'assetId': item.assetId,
                  'open': item.open,
                  'close': item.close,
                  'high': item.high,
                  'low': item.low,
                  'volume': item.volume
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<AssetPriceHistory> _assetPriceHistoryInsertionAdapter;

  @override
  Stream<List<AssetPriceHistory>> getAssetPriceHistory(String assetId) {
    return _queryAdapter.queryListStream(
        'SELECT * FROM AssetPriceHistory WHERE assetId = ?1 ORDER BY period ASC',
        mapper: (Map<String, Object?> row) => AssetPriceHistory(
            row['period'] as double?,
            row['open'] as double?,
            row['close'] as double?,
            row['high'] as double?,
            row['low'] as double?,
            row['volume'] as double?,
            row['assetId'] as String?),
        arguments: [assetId],
        queryableName: 'AssetPriceHistory',
        isView: false);
  }

  @override
  Future<void> insertPriceHistory(List<AssetPriceHistory> priceHistory) async {
    await _assetPriceHistoryInsertionAdapter.insertList(
        priceHistory, OnConflictStrategy.replace);
  }
}
