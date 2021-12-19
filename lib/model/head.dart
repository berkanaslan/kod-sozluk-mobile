import 'package:json_annotation/json_annotation.dart';
import 'package:kod_sozluk_mobile/model/base/serializable.dart';

part 'head.g.dart';

@JsonSerializable()
class Head extends Serializable {
  int? id;
  String? name;
  String? path;

  Head({this.id, this.name, this.path});

  static Head fromJson(Map<String, dynamic> json) => _$HeadFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$HeadToJson(this);

  @override
  String toString() {
    return 'Head{id: $id, name: $name, path: $path}';
  }
}
