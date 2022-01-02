import 'package:connectivity/connectivity.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ConnectivityViewModel extends Cubit<NetworkState> {
  ConnectivityViewModel() : super(const ConnectionInitial()) {
    Connectivity().onConnectivityChanged.listen((ConnectivityResult event) {
      if (event == ConnectivityResult.wifi ||
          event == ConnectivityResult.mobile) {
        emit(const ConnectionSuccess());
      } else if (event == ConnectivityResult.none) {
        emit(const ConnectionFailure());
      }
    });
  }
}

abstract class NetworkState {
  const NetworkState();
}

class ConnectionInitial extends NetworkState {
  const ConnectionInitial();
}

class ConnectionSuccess extends NetworkState {
  const ConnectionSuccess();
}

class ConnectionFailure extends NetworkState {
  const ConnectionFailure();
}
