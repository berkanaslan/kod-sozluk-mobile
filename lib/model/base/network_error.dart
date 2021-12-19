import 'package:dio/dio.dart';
import 'package:kod_sozluk_mobile/model/base/serializable.dart';

class NetworkError extends DioError implements Serializable {
  Result? result;

  NetworkError({this.result}) : super(requestOptions: RequestOptions(path: ""));

  static NetworkError fromJson(Map<String, dynamic> json) {
    final NetworkError networkErrorHandler = NetworkError();
    networkErrorHandler.result = json["result"] != null ? Result.fromJson(json["result"] as Map<String, dynamic>) : null;
    return networkErrorHandler;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};

    if (result != null) {
      data["result"] = result!.toJson();
    }

    return data;
  }
}

class Result implements Serializable {
  int? statusCode;
  String? message;
  String? detail;

  Result({this.statusCode, this.message, this.detail});

  static Result fromJson(Map<String, dynamic> json) {
    final Result result = Result();
    result.statusCode = json["statusCode"] as int;
    result.message = json["message"] as String;
    result.detail = json["detail"] as String;
    return result;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["statusCode"] = statusCode;
    data["message"] = message;
    data["detail"] = detail;
    return data;
  }

  @override
  String toString() {
    return 'Result{statusCode: $statusCode, message: $message, detail: $detail}';
  }
}
