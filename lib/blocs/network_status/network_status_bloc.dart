import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NetworkStatusState extends Equatable {
  final bool connected;

  NetworkStatusState(this.connected);

  @override
  List<Object?> get props => [connected];
}

abstract class NetworkStatusEvent extends Equatable {}

class NetworkStatusListenerStarted extends NetworkStatusEvent {
  NetworkStatusListenerStarted();

  @override
  List<Object?> get props => [];
}

class NetworkStatusBloc extends Bloc<NetworkStatusEvent, NetworkStatusState> {
  NetworkStatusBloc() : super(NetworkStatusState(true)) {
    on(_networkStatusListenerStarted);
  }

  FutureOr<void> _networkStatusListenerStarted(
      NetworkStatusEvent event, Emitter<NetworkStatusState> emit) async {
    await emit.forEach(Connectivity().onConnectivityChanged,
        onData: (ConnectivityResult data) {
      if (data != ConnectivityResult.none) {
        return NetworkStatusState(true);
      }
      return NetworkStatusState(false);
    });
  }
}
