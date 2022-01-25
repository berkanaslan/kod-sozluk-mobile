import 'package:json_annotation/json_annotation.dart';
import 'package:kod_sozluk_mobile/model/base/serilization_helper.dart';

abstract class Serializable {
  Map<String, dynamic> toJson();
}

abstract class Auditable extends Serializable {
  String? createdBy;
  @JsonKey(fromJson: dateTimeFromTimestamp)
  DateTime? creationDate;
  String? lastModifiedBy;
  @JsonKey(fromJson: dateTimeFromTimestamp)
  DateTime? lastModifiedDate;
}
