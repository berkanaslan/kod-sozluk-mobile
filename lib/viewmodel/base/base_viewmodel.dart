import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:kod_sozluk_mobile/core/constant/app_constants.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/dialog/app_exit_dialog.dart';
import 'package:kod_sozluk_mobile/model/base/network_error.dart';
import 'package:kod_sozluk_mobile/model/base/page.dart';
import 'package:kod_sozluk_mobile/model/base/serializable.dart';
import 'package:kod_sozluk_mobile/service/base/entity_service.dart';
import 'package:kod_sozluk_mobile/service/base/i_entity_service.dart';
import 'package:kod_sozluk_mobile/viewmodel/base/i_base_viewmodel.dart';

class BaseViewModel<T extends Serializable> extends Cubit<BaseEntityState> implements IEntityService<T> {
  final EntityService<T> service;

  BaseViewModel(BaseEntityState initialState, this.service) : super(initialState);

  // -------------------------------------------------------------------------------------------------------------------
  // LOADING INDICATOR                                                                                                 /
  // -------------------------------------------------------------------------------------------------------------------
  bool isLoading = false;

  void showLoading() {
    if (!isLoading) {
      isLoading = !isLoading;
      EasyLoading.show();
      emit(const LoadingState());
    }
  }

  void dismissLoading() {
    if (isLoading) {
      isLoading = !isLoading;
      EasyLoading.dismiss();
    }
  }

  // -------------------------------------------------------------------------------------------------------------------
  // HTTP REQUEST WRAPPERS                                                                                             /
  // -------------------------------------------------------------------------------------------------------------------
  @override
  Future<T?> get({
    String additionalPath = "",
    String requestParams = "",
  }) async {
    try {
      showLoading();

      final T? response = await service.get(
        additionalPath: additionalPath,
        requestParams: requestParams,
      );

      emit(CompletedState(response: response));

      return response;
    } on NetworkError catch (error) {
      emit(ErrorState(error));
      showNetworkError(error);
    } finally {
      dismissLoading();
    }
  }

  @override
  Future<List<T>?> getAll({
    String additionalPath = "",
    String requestParams = "",
  }) async {
    try {
      showLoading();

      final List<T>? responseList = await service.getAll(
        additionalPath: additionalPath,
        requestParams: requestParams,
      );

      emit(CompletedState(responseList: responseList));

      return responseList;
    } on NetworkError catch (error) {
      emit(ErrorState(error));
      showNetworkError(error);
    } finally {
      dismissLoading();
    }
  }

  @override
  Future<Page<T>?> getPaged({
    int pn = 0,
    int ps = AppConstants.PER_PAGE_20,
    String sb = "",
    String sd = AppConstants.SORT_ASC,
    String additionalPath = "",
    String requestParams = "",
  }) async {
    try {
      showLoading();

      final Page<T>? response = await service.getPaged(
        pn: pn,
        ps: ps,
        sb: sb,
        sd: sd,
        additionalPath: additionalPath,
        requestParams: requestParams,
      );

      emit(CompletedState(response: response));

      return response;
    } on NetworkError catch (error) {
      emit(ErrorState(error));
      showNetworkError(error);
    } finally {
      dismissLoading();
    }
  }

  @override
  Future<T?> post({
    required Serializable requestBody,
    String additionalPath = "",
    String requestParams = "",
  }) async {
    try {
      showLoading();

      final T? response = await service.post(
        requestBody: requestBody,
        additionalPath: additionalPath,
        requestParams: requestParams,
      );

      emit(CompletedState(response: response));

      return response;
    } on NetworkError catch (error) {
      emit(ErrorState(error));
      showNetworkError(error);
    } finally {
      dismissLoading();
    }
  }

  @override
  Future<List<T>?> postAll({
    required Serializable requestBody,
    String additionalPath = "",
    String requestParams = "",
  }) async {
    try {
      showLoading();

      final List<T>? responseList = await service.postAll(
        requestBody: requestBody,
        additionalPath: additionalPath,
        requestParams: requestParams,
      );

      emit(CompletedState(responseList: responseList));

      return responseList;
    } on NetworkError catch (error) {
      emit(ErrorState(error));
      showNetworkError(error);
    } finally {
      dismissLoading();
    }
  }

  @override
  Future<Page<T>?> postPaged({
    required Serializable requestBody,
    int pn = 0,
    int ps = AppConstants.PER_PAGE_20,
    String sb = "",
    String sd = AppConstants.SORT_ASC,
    String additionalPath = "",
    String requestParams = "",
  }) async {
    try {
      showLoading();

      final Page<T>? response = await service.postPaged(
        pn: pn,
        ps: ps,
        sb: sb,
        sd: sd,
        requestBody: requestBody,
        additionalPath: additionalPath,
        requestParams: requestParams,
      );

      emit(CompletedState(response: response));

      return response;
    } on NetworkError catch (error) {
      emit(ErrorState(error));
      showNetworkError(error);
    } finally {
      dismissLoading();
    }
  }

  @override
  Future<List<T>?> postAllList({
    required List<Serializable> requestBody,
    String additionalPath = "",
    String requestParams = "",
  }) async {
    try {
      showLoading();

      final List<T>? responseList = await service.postAllList(
        requestBody: requestBody,
        additionalPath: additionalPath,
        requestParams: requestParams,
      );

      emit(CompletedState(responseList: responseList));

      return responseList;
    } on NetworkError catch (error) {
      emit(ErrorState(error));
      showNetworkError(error);
    } finally {
      dismissLoading();
    }
  }

  @override
  Future<bool?> delete({
    String additionalPath = "",
    String requestParams = "",
  }) async {
    try {
      showLoading();

      bool? response = await service.delete(
        additionalPath: additionalPath,
        requestParams: requestParams,
      );

      response ??= false;

      emit(CompletedState(deleted: response));

      return response;
    } on NetworkError catch (error) {
      emit(ErrorState(error));
      showNetworkError(error);
    } finally {
      dismissLoading();
    }
  }

  void showNetworkError(NetworkError error) {
    AppAlertDialog.show(
      error.status == null ? LocaleKeys.error.locale : error.status!,
      error.detail == null ? LocaleKeys.error.locale : error.detail!,
    );
  }
}
