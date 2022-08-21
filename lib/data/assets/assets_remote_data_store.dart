import 'package:coin_watch/models/asset.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'assets_remote_data_store.g.dart';

@RestApi(baseUrl: "https://api.coincap.io/v2")
abstract class AssetsRemoteDataStore {
  factory AssetsRemoteDataStore(Dio dio, {String baseUrl}) = _AssetsRemoteDataStore;

  @GET("/assets")
  Future<AssetApiResponse> getAssets();
}
