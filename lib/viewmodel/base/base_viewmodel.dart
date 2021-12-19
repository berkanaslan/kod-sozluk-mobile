import 'package:flutter/material.dart' hide Page;
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:kod_sozluk_mobile/core/constant/app_constants.dart';
import 'package:kod_sozluk_mobile/core/constant/extension/string_extension.dart';
import 'package:kod_sozluk_mobile/core/constant/lang/locale_keys.g.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_icons.dart';
import 'package:kod_sozluk_mobile/core/ui/theme/app_theme.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/sized_box/app_sized_box.dart';
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
      EasyLoading.show(status: "Loading");
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
  Future<T?> get({String requestParams = ""}) async {
    try {
      showLoading();

      final T? response = await service.get(requestParams: requestParams);

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
  Future<List<T>?> getAll({String requestParams = ""}) async {
    try {
      showLoading();

      final List<T>? responseList = await service.getAll(requestParams: requestParams);

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
    String? sb,
    String sd = AppConstants.SORT_DESC,
    String requestParams = "",
  }) async {
    try {
      showLoading();

      final Page<T>? response = await service.getPaged(
        pn: pn,
        ps: ps,
        sb: sb,
        sd: sd,
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
  Future<T?> post({required Serializable requestBody, String requestParams = ""}) async {
    try {
      showLoading();

      final T? response = await service.post(
        requestBody: requestBody,
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
  Future<List<T>?> postAll({required Serializable requestBody, String requestParams = ""}) async {
    try {
      showLoading();

      final List<T>? responseList = await service.postAll(
        requestBody: requestBody,
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
  Future<List<T>?> postAllList({required List<Serializable> requestBody, String requestParams = ""}) async {
    try {
      showLoading();

      final List<T>? responseList = await service.postAllList(
        requestBody: requestBody,
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
    String? sb,
    String sd = AppConstants.SORT_DESC,
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
  Future<bool?> delete({String requestParams = ""}) async {
    try {
      showLoading();

      bool? response = await service.delete(requestParams: requestParams);
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
    Get.generalDialog(
      barrierColor: Colors.black.withOpacity(0.5),
      transitionBuilder: (context, a1, a2, widget) => Transform.scale(
        scale: a1.value,
        child: Opacity(
          opacity: a1.value,
          child: AlertDialog(
            titlePadding: const EdgeInsets.fromLTRB(8.0, 16.0, 8.0, 8.0),
            shape: OutlineInputBorder(borderRadius: BorderRadius.circular(16.0)),
            title: Center(
              child: Column(
                children: [
                  const Icon(AppIcons.warning, color: AppColors.error),
                  Text(
                    error.result?.message == null ? LocaleKeys.error.locale : error.result!.message!,
                    style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.primary),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
            content: Text(error.result?.detail == null ? LocaleKeys.error.locale : error.result!.detail!),
            actions: [TextButton(child: Text(LocaleKeys.close.locale), onPressed: () => Get.back())],
          ),
        ),
      ),
      transitionDuration: const Duration(milliseconds: 200),
      barrierLabel: "",
      barrierDismissible: true,
      pageBuilder: (context, animation1, animation2) => const AppSizedBox(style: AppBoxStyle.EMPTY),
    );
  }
}
