import 'package:json_annotation/json_annotation.dart';
import 'package:kod_sozluk_mobile/model/base/serializable.dart';

part 'topic.g.dart';

@JsonSerializable()
class Topic extends Serializable {
  int? id;
  String? name;

  Topic({this.id, this.name});

  static Topic fromJson(Map<String, dynamic> json) => _$TopicFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$TopicToJson(this);

  @override
  String toString() {
    return 'Topic{id: $id, name: $name}';
  }
}
