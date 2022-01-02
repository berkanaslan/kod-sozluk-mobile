import 'package:json_annotation/json_annotation.dart';
import 'package:kod_sozluk_mobile/core/ui/widget/text_field/gender_text_field.dart';
import 'package:kod_sozluk_mobile/model/base/serializable.dart';

part 'user_dto.g.dart';

@JsonSerializable(includeIfNull: false)
class UserDTO implements Serializable {
  @JsonKey(includeIfNull: false)
  String? username;

  @JsonKey(includeIfNull: false)
  String? email;

  @JsonKey(includeIfNull: false)
  String? password;

  @JsonKey(includeIfNull: false)
  String? gender;

  @JsonKey(includeIfNull: false)
  String? dateOfBirth;

  @JsonKey(ignore: true)
  bool agreementConfirmed = false;

  @JsonKey(ignore: true)
  Gender genderEnum = Gender.FEMALE;

  UserDTO({
    this.username,
    this.email,
    this.gender,
    this.password,
    this.dateOfBirth,
  });

  static UserDTO fromJson(Map<String, dynamic> json) => _$UserDTOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserDTOToJson(this);

  @override
  String toString() {
    return 'UserDTO{username: $username, email: $email, password: $password, gender: $gender, dateOfBirth: $dateOfBirth, agreementConfirmed: $agreementConfirmed, genderEnum: $genderEnum}';
  }
}
