import 'package:json_annotation/json_annotation.dart';
import 'package:kod_sozluk_mobile/model/base/serializable.dart';
import 'package:kod_sozluk_mobile/model/base/serilization_helper.dart';

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
  ConnectedApplications? connectedApplications;
  int? entryCount;
  int? followersCount;
  int? followingCount;

  User({
    this.id,
    this.username,
    this.email,
    this.enabled,
    this.blocked,
    this.role,
    this.connectedApplications,
    this.entryCount,
    this.followersCount,
    this.followingCount,
  });

  static User fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  @override
  Map<String, dynamic> toJson() => _$UserToJson(this);

  @override
  String toString() {
    return 'User{id: $id, username: $username, email: $email, enabled: $enabled, blocked: $blocked, role: $role, gender: $gender, dateOfBirth: $dateOfBirth}';
  }
}

@JsonSerializable()
class ConnectedApplications extends Serializable {
  String? facebook;
  String? twitter;
  String? instagram;
  String? github;

  ConnectedApplications({this.facebook, this.twitter, this.instagram, this.github});

  static ConnectedApplications fromJson(Map<String, dynamic> json) => _$ConnectedApplicationsFromJson(json);

  static const String PATH_DELIMITER = "/";

  static String getJustUsernameOfLink(String? url) {
    if (url == null) return "";

    if (!url.contains(PATH_DELIMITER)) return url;

    return url.split(PATH_DELIMITER).last;
  }

  @override
  Map<String, dynamic> toJson() => _$ConnectedApplicationsToJson(this);

  @override
  String toString() {
    return 'ConnectedApplications{facebook: $facebook, twitter: $twitter, instagram: $instagram, github: $github}';
  }
}
