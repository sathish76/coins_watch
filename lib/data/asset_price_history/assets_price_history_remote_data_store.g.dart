// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'assets_price_history_remote_data_store.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers

class _AssetsPriceHistoryRemoteDataStore
    implements AssetsPriceHistoryRemoteDataStore {
  _AssetsPriceHistoryRemoteDataStore(this._dio, {this.baseUrl}) {
    baseUrl ??= 'https://api.coincap.io/v2';
  }

  final Dio _dio;

  String? baseUrl;

  @override
  Future<AssetPriceHistoryResponse> getAssetPriceHistory(
      assetId, interval, startTime, endTime) async {
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'baseId': assetId,
      r'interval': interval,
      r'start': startTime,
      r'end': endTime
    };
    final _headers = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.fetch<Map<String, dynamic>>(
        _setStreamType<AssetPriceHistoryResponse>(
            Options(method: 'GET', headers: _headers, extra: _extra)
                .compose(
                    _dio.options, '/candles?exchange=binance&quoteId=tether',
                    queryParameters: queryParameters, data: _data)
                .copyWith(baseUrl: baseUrl ?? _dio.options.baseUrl)));
    final value = AssetPriceHistoryResponse.fromJson(_result.data!);
    return value;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }
}
