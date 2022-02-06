import 'package:json_annotation/json_annotation.dart';
import 'package:kod_sozluk_mobile/model/base/serializable.dart';
import 'package:kod_sozluk_mobile/model/topic.dart';
import 'package:kod_sozluk_mobile/model/user.dart';

part 'entry_dto.g.dart';

@JsonSerializable()
class EntryDTO extends Serializable {
  int? id;
  String message;
  Topic topic;
  User author;

  EntryDTO({
    this.id,
    required this.message,
    required this.topic,
    required this.author,
  });

  static EntryDTO fromJson(Map<String, dynamic> json) => _$EntryDTOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$EntryDTOToJson(this);
}
