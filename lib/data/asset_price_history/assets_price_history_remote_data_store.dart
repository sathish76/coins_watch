import 'package:coin_watch/models/asset_price_history.dart';
import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';

part 'assets_price_history_remote_data_store.g.dart';

@RestApi(baseUrl: "https://api.coincap.io/v2")
abstract class AssetsPriceHistoryRemoteDataStore {
  factory AssetsPriceHistoryRemoteDataStore(Dio dio, {String baseUrl}) =
      _AssetsPriceHistoryRemoteDataStore;

  @GET("/candles?exchange=binance&quoteId=tether")
  Future<AssetPriceHistoryResponse> getAssetPriceHistory(
      @Query('baseId') String assetId,
      @Query('interval') String interval,
      @Query('start') int startTime,
      @Query('end') int endTime);
}
