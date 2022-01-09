import 'package:kod_sozluk_mobile/core/constant/app_constants.dart';
import 'package:kod_sozluk_mobile/model/base/page.dart';
import 'package:kod_sozluk_mobile/model/base/serializable.dart';

abstract class IEntityService<T extends Serializable> {
  Future<T?> get({
    String requestParams = "",
    String additionalPath = "",
  });

  Future<List<T>?> getAll({
    String requestParams = "",
    String additionalPath = "",
  });

  Future<Page<T>?> getPaged({
    int pn = 0,
    int ps = AppConstants.PER_PAGE_20,
    String sb = "",
    String sd = AppConstants.SORT_ASC,
    String additionalPath = "",
    String requestParams = "",
  });

  Future<T?> post({
    required Serializable requestBody,
    String requestParams = "",
    String additionalPath = "",
  });

  Future<List<T>?> postAll({
    required Serializable requestBody,
    String requestParams = "",
    String additionalPath = "",
  });

  Future<List<T>?> postAllList({
    required List<Serializable> requestBody,
    String requestParams = "",
    String additionalPath = "",
  });

  Future<Page<T>?> postPaged(
      {required Serializable requestBody,
      int pn = 0,
      int ps = AppConstants.PER_PAGE_20,
      String sb = "",
      String sd = AppConstants.SORT_ASC,
      String requestParams = "",
      String additionalPath = ""});

  Future<bool?> delete({
    String requestParams = "",
    String additionalPath = "",
  });
}
