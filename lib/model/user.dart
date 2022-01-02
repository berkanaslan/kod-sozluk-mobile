import 'package:json_annotation/json_annotation.dart';
import 'package:kod_sozluk_mobile/model/base/serializable.dart';

part 'user.g.dart';

@JsonSerializable()
class User extends Serializable {
  int? id;
  String? username;
  String? email;
  bool? enabled;
  bool? blocked;
  String? role;
  String? gender;

  @JsonKey(fromJson: dateTimeFromTimestamp)
  DateTime? dateOfBirth;

  User({
    this.id,
    this.username,
    this.email,
    this.enabled,
    this.blocked,
    this.role,
  });

  static User fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  static DateTime? dateTimeFromTimestamp(dynamic dateOfBirth) {
    if (dateOfBirth is int) {
      return DateTime.fromMillisecondsSinceEpoch(dateOfBirth);
    }

    if (dateOfBirth is DateTime) {
      return dateOfBirth;
    }

    if (dateOfBirth is String) {
      return DateTime.tryParse(dateOfBirth);
    }
  }

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User{id: $id, username: $username, email: $email, enabled: $enabled, blocked: $blocked, role: $role, gender: $gender, dateOfBirth: $dateOfBirth}';
  }
}
