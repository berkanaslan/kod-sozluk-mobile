import 'package:json_annotation/json_annotation.dart';
import 'package:kod_sozluk_mobile/model/base/serializable.dart';
import 'package:kod_sozluk_mobile/model/base/serilization_helper.dart';
import 'package:kod_sozluk_mobile/model/topic.dart';
import 'package:kod_sozluk_mobile/model/user.dart';

part 'entry.g.dart';

@JsonSerializable()
class Entry extends Auditable {
  int? id;
  Topic? topic;
  String? message;
  List<User>? favorites;
  int? favoritesCount;
  User? author;

  @JsonKey(ignore: true)
  bool? _expanded;

  bool? get expanded {
    if (_expanded == null) return message != null && message!.length <= 240;
    return _expanded;
  }

  set expanded(bool? expanded) {
    _expanded = expanded;
  }

  Entry({
    this.id,
    this.topic,
    this.message,
    this.favorites,
    this.favoritesCount,
    this.author,
  });

  static Entry fromJson(Map<String, dynamic> json) => _$EntryFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EntryToJson(this);
}
