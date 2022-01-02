// -------------------------------------------------------------------------------------------------------------------
// BASE ENTITY STATE => Deals with:                                                                                  /
// - InitialState                                                                                                    /
// - LoadingState                                                                                                    /
// - CompletedState                                                                                                  /
// - Error State                                                                                                     /
// -------------------------------------------------------------------------------------------------------------------
import 'package:kod_sozluk_mobile/model/base/network_error.dart';
import 'package:kod_sozluk_mobile/model/base/serializable.dart';

abstract class BaseEntityState {
  const BaseEntityState();
}

// Initial
class InitialState extends BaseEntityState {
  const InitialState();
}

// Loading
class LoadingState extends BaseEntityState {
  const LoadingState();
}

// Completed
class CompletedState<T extends Serializable> extends BaseEntityState {
  final T? response;
  final List<T>? responseList;
  final bool? deleted;

  CompletedState({this.response, this.responseList, this.deleted});
}

// Error
class ErrorState extends BaseEntityState {
  final NetworkError networkError;

  const ErrorState(this.networkError);
}

