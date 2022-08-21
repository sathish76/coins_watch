import 'dart:async';

import 'package:coin_watch/utils/response.dart';


/// This class does the following steps to maintain single source of truth
/// 1. Create a stream subscription to db query, whenever the data arrives add it to the stream
/// 2. Perform remote call
/// 3. Map remote api response to db model
/// 4. Save the remote data to local db, newly inserted data will flow in the subscription handler.

class SingleSourceOfTruth<ResultType, RequestType> {
  late StreamController<Response<ResultType>> _result;

  bool saveToDbInProgress = false;

  Stream<Response<ResultType>> asStream({
    required Stream<ResultType> Function() dbQuery,
    required Future<RequestType> Function() remoteCall,
    required Future saveToDb(ResultType item),
    required ResultType mapApiResponseToDbRecord(RequestType result),
  }) {
    StreamSubscription? localListener;

    _result = StreamController<Response<ResultType>>(
      onCancel: () {
        if (!_result.hasListener) {
          _result.close();
          localListener?.cancel();
        }
      },
    );

    _fetchFromNetwork(remoteCall, saveToDb, mapApiResponseToDbRecord);

    final localStream = dbQuery().transform(
      StreamTransformer<ResultType, Response<ResultType>>.fromHandlers(
        handleData: (data, sink) async {
          print("Fetching from local store / local data has been changed");
          sink.add(Response.success(data: data));
        },
      ),
    );

    _result.sink.add(Response.loading());

    localListener = localStream.listen(_result.sink.add);

    return _result.stream;
  }

  Future<RequestType> _fetchFromNetwork(
    Future<RequestType> Function() remoteCall,
    Future Function(ResultType item) saveCallResult,
    ResultType processResponse(RequestType result),
  ) async {
    return await remoteCall().then((value) async {
      print("Fetching from remote source");
      await saveCallResult(processResponse(value));
      print("Saved to local db");
      return value;
    });
  }
}
