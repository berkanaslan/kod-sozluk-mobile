import 'package:json_annotation/json_annotation.dart';
import 'package:kod_sozluk_mobile/model/base/serializable.dart';

part 'user_dto.g.dart';

@JsonSerializable()
class UserDTO implements Serializable {
  String? username;
  String? password;

  UserDTO({this.username, this.password});

  static UserDTO fromJson(Map<String, dynamic> json) => _$UserDTOFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserDTOToJson(this);

  @override
  String toString() {
    return 'UserDTO{username: $username, password: $password}';
  }
}
