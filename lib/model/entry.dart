import 'package:json_annotation/json_annotation.dart';
import 'package:kod_sozluk_mobile/model/base/serializable.dart';
import 'package:kod_sozluk_mobile/model/topic.dart';
import 'package:kod_sozluk_mobile/model/user.dart';

part 'entry.g.dart';

@JsonSerializable()
class Entry extends Serializable {
  int? id;
  String? createdBy;
  String? creationDate;
  String? lastModifiedDate;
  Topic? topic;
  String? message;
  List<User>? favorites;
  int? favoritesCount;

  Entry({
    this.id,
    this.createdBy,
    this.creationDate,
    this.lastModifiedDate,
    this.topic,
    this.message,
    this.favorites,
    this.favoritesCount,
  });

  static Entry fromJson(Map<String, dynamic> json) => _$EntryFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EntryToJson(this);
}
