// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i4;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

import '../data/asset_price_history/asset_price_history_dao.dart' as _i8;
import '../data/asset_price_history/assets_price_history_remote_data_store.dart'
    as _i3;
import '../data/assets/assets_dao.dart' as _i7;
import '../data/assets/assets_remote_data_store.dart' as _i5;
import '../data/repository/asset_list_repo.dart' as _i6;
import 'di.dart' as _i9; // ignore_for_file: unnecessary_lambdas

// ignore_for_file: lines_longer_than_80_chars
/// initializes the registration of provided dependencies inside of [GetIt]
_i1.GetIt $initGetIt(_i1.GetIt get,
    {String? environment, _i2.EnvironmentFilter? environmentFilter}) {
  final gh = _i2.GetItHelper(get, environment, environmentFilter);
  final retrofitInjectableModule2 = _$RetrofitInjectableModule2();
  final retrofitInjectableModule = _$RetrofitInjectableModule();
  gh.factory<_i3.AssetsPriceHistoryRemoteDataStore>(
      () => retrofitInjectableModule2.getService(get<_i4.Dio>()));
  gh.factory<_i5.AssetsRemoteDataStore>(
      () => retrofitInjectableModule.getService(get<_i4.Dio>()));
  gh.factory<_i6.AssetRepository>(() => _i6.AssetRepositoryImpl(
      get<_i7.AssetsDao>(),
      get<_i5.AssetsRemoteDataStore>(),
      get<_i8.AssetPriceHistoryDao>(),
      get<_i3.AssetsPriceHistoryRemoteDataStore>()));
  return get;
}

class _$RetrofitInjectableModule2 extends _i9.RetrofitInjectableModule2 {}

class _$RetrofitInjectableModule extends _i9.RetrofitInjectableModule {}
