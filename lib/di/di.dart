import 'package:coin_watch/data/asset_price_history/assets_price_history_remote_data_store.dart';
import 'package:coin_watch/data/assets/assets_remote_data_store.dart';
import 'package:coin_watch/data/asset_price_history/asset_price_history_dao.dart';
import 'package:coin_watch/data/assets/assets_dao.dart';
import 'package:coin_watch/database/database.dart';
import 'package:coin_watch/di/di.config.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

final getIt = GetIt.instance;

@InjectableInit(
  initializerName: r'$initGetIt',
  preferRelativeImports: true,
  asExtension: false,
)
Future<void> configureDependencies() async {
  final dio = Dio();
  dio.options.baseUrl = 'https://api.coincap.io/v2';
  getIt.registerFactory<Dio>(() => dio);

  final db = await $FloorAppDatabase.databaseBuilder('app.db').build();
  getIt.registerFactory<AssetsDao>(() => db.assetDao);
  getIt.registerFactory<AssetPriceHistoryDao>(() => db.assetPriceHistoryDao);

  $initGetIt(getIt);
}

@module
abstract class RetrofitInjectableModule {
  AssetsRemoteDataStore getService(Dio client) => AssetsRemoteDataStore(client);
}

@module
abstract class RetrofitInjectableModule2 {
  AssetsPriceHistoryRemoteDataStore getService(Dio client) => AssetsPriceHistoryRemoteDataStore(client);
}
