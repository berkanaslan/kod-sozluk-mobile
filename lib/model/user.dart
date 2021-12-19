import 'package:json_annotation/json_annotation.dart';
import 'package:kod_sozluk_mobile/model/base/serializable.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Serializable {
  int? id;
  String? username;
  String? email;
  String? firstName;
  String? lastName;
  bool? enabled;
  bool? blocked;
  String? role;

  User({
    this.id,
    this.username,
    this.email,
    this.firstName,
    this.lastName,
    this.enabled,
    this.blocked,
    this.role,
  });

  static User fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);
}
