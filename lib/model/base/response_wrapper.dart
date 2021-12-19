import 'package:json_annotation/json_annotation.dart';
import 'package:kod_sozluk_mobile/model/base/serializable.dart';

part 'response_wrapper.g.dart';

class ResponseWrapper<T extends Serializable> {
  Result? result;
  T? data;
  List<T>? dataList;

  ResponseWrapper({this.result, this.data, this.dataList});

  factory ResponseWrapper.fromJson(
      {required Map<String, dynamic> json, required Function(Map<String, dynamic>) mapper}) {
    final ResponseWrapper<T> rw = ResponseWrapper<T>();

    rw.data = mapper(json["data"] as Map<String, dynamic>) as T;

    if (json["result"] != null) {
      rw.result = Result.fromJson(json["result"] as Map<String, dynamic>);
    }

    return rw;
  }

  factory ResponseWrapper.fromJsonList(
      {required Map<String, dynamic> json, required Function(Map<String, dynamic>) mapper}) {
    final ResponseWrapper<T> rw = ResponseWrapper<T>();

    if (json["result"] != null) rw.result = Result.fromJson(json["result"] as Map<String, dynamic>);

    if (json['data'] != null) {
      rw.dataList = <T>[];

      rw.dataList = (json['data'] as List).map<T>((data) => mapper(data as Map<String, dynamic>) as T).toList();
    }

    return rw;
  }

  @override
  String toString() {
    return 'ResponseWrapper{result: $result, data: $data, dataList: $dataList}';
  }
}

@JsonSerializable()
class Result {
  int? statusCode;
  String? message;

  Result({this.statusCode, this.message});

  static Result fromJson(Map<String, dynamic> json) => _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);

  @override
  String toString() {
    return 'Result{statusCode: $statusCode, message: $message}';
  }
}
