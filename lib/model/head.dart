import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:kod_sozluk_mobile/model/base/serializable.dart';

part 'head.g.dart';

@JsonSerializable()
class Head extends Serializable {
  int? id;
  String? name;
  String? path;

  @JsonKey(ignore: true)
  Widget? body;

  Head({
    this.id,
    this.name,
    this.path,
    this.body,
  });

  static Head fromJson(Map<String, dynamic> json) => _$HeadFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$HeadToJson(this);

  @override
  String toString() {
    return 'Head{id: $id, name: $name, path: $path}';
  }
}
