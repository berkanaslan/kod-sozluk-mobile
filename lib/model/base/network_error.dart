import 'package:dio/dio.dart';
import 'package:kod_sozluk_mobile/model/base/serializable.dart';

class NetworkError extends DioError implements Serializable {
  String? status;
  String? detail;

  NetworkError({this.status, this.detail}) : super(requestOptions: RequestOptions(path: ""));

  static NetworkError fromJson(Map<String, dynamic> json) {
    final NetworkError result = NetworkError();
    result.status = json["status"] as String;
    result.detail = json["detail"] as String;
    return result;
  }

  @override
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data["status"] = status;
    data["detail"] = detail;
    return data;
  }

  @override
  String toString() {
    return 'NetworkError{statusCode: $status, detail: $detail}';
  }
}
