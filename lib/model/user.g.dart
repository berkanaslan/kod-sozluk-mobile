// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      enabled: json['enabled'] as bool?,
      blocked: json['blocked'] as bool?,
      role: json['role'] as String?,
      connectedApplications: json['connectedApplications'] == null
          ? null
          : ConnectedApplications.fromJson(
              json['connectedApplications'] as Map<String, dynamic>),
      entryCount: json['entryCount'] as int?,
      followersCount: json['followersCount'] as int?,
      followingCount: json['followingCount'] as int?,
    )
      ..gender = json['gender'] as String?
      ..dateOfBirth = dateTimeFromTimestamp(json['dateOfBirth']);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'enabled': instance.enabled,
      'blocked': instance.blocked,
      'role': instance.role,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
      'connectedApplications': instance.connectedApplications,
      'entryCount': instance.entryCount,
      'followersCount': instance.followersCount,
      'followingCount': instance.followingCount,
    };

ConnectedApplications _$ConnectedApplicationsFromJson(
        Map<String, dynamic> json) =>
    ConnectedApplications(
      facebook: json['facebook'] as String?,
      twitter: json['twitter'] as String?,
      instagram: json['instagram'] as String?,
      github: json['github'] as String?,
    );

Map<String, dynamic> _$ConnectedApplicationsToJson(
        ConnectedApplications instance) =>
    <String, dynamic>{
      'facebook': instance.facebook,
      'twitter': instance.twitter,
      'instagram': instance.instagram,
      'github': instance.github,
    };
