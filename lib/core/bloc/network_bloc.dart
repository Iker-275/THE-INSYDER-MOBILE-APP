import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

enum NetworkStatus { connected, disconnected }

class NetworkState {
  final NetworkStatus status;
  const NetworkState(this.status);
}

abstract class NetworkEvent {}

class NetworkStatusChanged extends NetworkEvent {
  final NetworkStatus status;
  NetworkStatusChanged(this.status);
}

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  late final StreamSubscription _connectivitySubscription;

  NetworkBloc() : super(const NetworkState(NetworkStatus.connected)) {
    on<NetworkStatusChanged>((event, emit) {
      emit(NetworkState(event.status));
    });

    _connectivitySubscription =
        Connectivity().onConnectivityChanged.listen((result) {
      if (result == ConnectivityResult.none) {
        add(NetworkStatusChanged(NetworkStatus.disconnected));
      } else {
        add(NetworkStatusChanged(NetworkStatus.connected));
      }
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
