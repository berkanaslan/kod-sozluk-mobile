import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:kod_sozluk_mobile/core/constant/app_constants.dart';
import 'package:kod_sozluk_mobile/core/constant/uri_constants.dart';
import 'package:kod_sozluk_mobile/model/base/page.dart';
import 'package:kod_sozluk_mobile/model/base/response_wrapper.dart';
import 'package:kod_sozluk_mobile/model/base/serializable.dart';
import 'package:kod_sozluk_mobile/service/base/http_client.dart';
import 'package:kod_sozluk_mobile/service/base/i_entity_service.dart';

class EntityService<T extends Serializable> extends HttpClient implements IEntityService<T> {
  final String path;
  final Function(Map<String, dynamic>) fromJson;

  EntityService({required this.path, required this.fromJson});

  static CancelToken cancelToken = CancelToken();

  // -------------------------------------------------------------------------------------------------------------------
  // GET - GET ALL - GET PAGED                                                                                         /
  // -------------------------------------------------------------------------------------------------------------------
  @override
  Future<T?> get({String requestParams = ""}) async {
    cancelToken = CancelToken();

    final Response response = await client.get(getURL(requestParams), cancelToken: cancelToken);
    final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;

    final ResponseWrapper<T> rw = ResponseWrapper.fromJson(json: responseData, mapper: fromJson);
    return rw.data;
  }

  @override
  Future<List<T>?> getAll({String requestParams = ""}) async {
    cancelToken = CancelToken();

    final Response response = await client.get(getURL(requestParams), cancelToken: cancelToken);
    final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;

    final ResponseWrapper<T> rw = ResponseWrapper.fromJsonList(json: responseData, mapper: fromJson);
    return rw.dataList;
  }

  @override
  Future<Page<T>?> getPaged({
    int pn = 0,
    int ps = AppConstants.PER_PAGE_20,
    String sb = "",
    String sd = AppConstants.SORT_DESC,
    String requestParams = "",
  }) async {
    cancelToken = CancelToken();

    final String divider = requestParams.isEmpty ? "?" : "&";
    final String url = "${getURL(requestParams)}${divider}pn=$pn&ps=$ps&sb=$sb&sd=$sd";

    final Response response = await client.get(url, cancelToken: cancelToken);
    final Map<String, dynamic> responseData = response.data["data"] as Map<String, dynamic>;

    final Page<T> page = Page.fromJson<T>(responseData);
    page.content =
        (responseData["content"] as List).map<T>((data) => fromJson(data as Map<String, dynamic>) as T).toList();

    return page;
  }

  // -------------------------------------------------------------------------------------------------------------------
  // POST - POST ALL - POST PAGED                                                                                      /
  // -------------------------------------------------------------------------------------------------------------------
  @override
  Future<T?> post({required Serializable requestBody, String requestParams = ""}) async {
    cancelToken = CancelToken();

    final Response response = await client.post(
      getURL(requestParams),
      data: jsonEncode(requestBody.toJson()),
      cancelToken: cancelToken,
    );

    final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;

    final ResponseWrapper<T> rw = ResponseWrapper.fromJson(json: responseData, mapper: fromJson);
    return rw.data;
  }

  @override
  Future<List<T>?> postAll({required Serializable requestBody, String requestParams = ""}) async {
    cancelToken = CancelToken();

    final Response response = await client.post(
      getURL(requestParams),
      data: jsonEncode(requestBody.toJson()),
      cancelToken: cancelToken,
    );

    final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;

    final ResponseWrapper<T> rw = ResponseWrapper.fromJsonList(json: responseData, mapper: fromJson);
    return rw.dataList!;
  }

  @override
  Future<List<T>?> postAllList({required List<Serializable> requestBody, String requestParams = ""}) async {
    cancelToken = CancelToken();

    final Response response = await client.post(
      getURL(requestParams),
      data: requestBody.map((e) => e.toJson()).toList(),
      cancelToken: cancelToken,
    );

    final Map<String, dynamic> responseData = response.data as Map<String, dynamic>;

    final ResponseWrapper<T> rw = ResponseWrapper.fromJsonList(json: responseData, mapper: fromJson);
    return rw.dataList!;
  }

  @override
  Future<Page<T>?> postPaged({
    required Serializable requestBody,
    int pn = 0,
    int ps = AppConstants.PER_PAGE_20,
    String sb = "",
    String sd = AppConstants.SORT_DESC,
    String requestParams = "",
  }) async {
    cancelToken = CancelToken();

    final String divider = requestParams.isEmpty ? "&" : "?";
    final String url = "${getURL(requestParams)}${divider}pn=$pn&ps=$ps&sb=$sb&sd=$sd";

    final Response response = await client.post(url, data: jsonEncode(requestBody.toJson()), cancelToken: cancelToken);
    final Map<String, dynamic> responseData = response.data["data"] as Map<String, dynamic>;

    final Page<T> page = Page.fromJson<T>(responseData);
    page.content =
        (responseData["content"] as List).map<T>((data) => fromJson(data as Map<String, dynamic>) as T).toList();

    return page;
  }

  // -------------------------------------------------------------------------------------------------------------------
  // DELETE                                                                                                            /
  // -------------------------------------------------------------------------------------------------------------------
  @override
  Future<bool?> delete({String requestParams = ""}) async {
    cancelToken = CancelToken();

    final response = await client.delete(getURL(requestParams), cancelToken: cancelToken);
    return response.statusCode == HttpStatus.ok;
  }

  String getURL(String requestParams) {
    return (URLConstants.URL + path.trim() + requestParams.trim()).trim();
  }
}
