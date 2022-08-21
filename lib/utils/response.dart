import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

enum Status { loading, success, failed }

@immutable
class Response<T> extends Equatable {
  final Status status;
  final T? data;
  final String? message;
  final Exception? error;

  bool get isSuccess => status == Status.success;
  bool get isLoading => status == Status.loading;
  bool get isFailed => status == Status.failed;

  const Response({this.data, required this.status, this.message, this.error});

  static Response<T> loading<T>({T? data}) => Response<T>(data: data, status: Status.loading);

  static Response<T> failed<T>({Exception? error, T? data}) =>
      Response<T>(error: error, data: data, status: Status.failed);

  static Response<T> success<T>({T? data}) => Response<T>(data: data, status: Status.success);

  static FutureOr<Response<T>> asFuture<T>(FutureOr<T> Function() req) async {
    try {
      final res = await req();
      return success<T>(data: res);
    } on Exception catch (e) {
      return Future.error(failed(error: e, data: null));
    }
  }

  @override
  List<Object?> get props => [status, data, message, error];
}
