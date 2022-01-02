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
    )
      ..gender = json['gender'] as String?
      ..dateOfBirth = User.dateTimeFromTimestamp(json['dateOfBirth']);

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'enabled': instance.enabled,
      'blocked': instance.blocked,
      'role': instance.role,
      'gender': instance.gender,
      'dateOfBirth': instance.dateOfBirth?.toIso8601String(),
    };
