// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Entry _$EntryFromJson(Map<String, dynamic> json) => Entry(
      id: json['id'] as int?,
      topic: json['topic'] == null
          ? null
          : Topic.fromJson(json['topic'] as Map<String, dynamic>),
      message: json['message'] as String?,
      favorites: (json['favorites'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      favoritesCount: json['favoritesCount'] as int?,
      author: json['author'] == null
          ? null
          : User.fromJson(json['author'] as Map<String, dynamic>),
      favorited: json['favorited'] as bool,
      createdAt: dateTimeFromTimestamp(json['createdAt']),
      modifiedAt: dateTimeFromTimestamp(json['modifiedAt']),
    )..expanded = json['expanded'] as bool?;

Map<String, dynamic> _$EntryToJson(Entry instance) => <String, dynamic>{
      'id': instance.id,
      'topic': instance.topic,
      'message': instance.message,
      'favorites': instance.favorites,
      'favoritesCount': instance.favoritesCount,
      'author': instance.author,
      'favorited': instance.favorited,
      'createdAt': instance.createdAt?.toIso8601String(),
      'modifiedAt': instance.modifiedAt?.toIso8601String(),
      'expanded': instance.expanded,
    };
