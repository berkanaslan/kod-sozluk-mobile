// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Entry _$EntryFromJson(Map<String, dynamic> json) => Entry(
      id: json['id'] as int?,
      createdBy: json['createdBy'] as String?,
      creationDate: json['creationDate'] as String?,
      lastModifiedDate: json['lastModifiedDate'] as String?,
      topic: json['topic'] == null
          ? null
          : Topic.fromJson(json['topic'] as Map<String, dynamic>),
      message: json['message'] as String?,
      favorites: (json['favorites'] as List<dynamic>?)
          ?.map((e) => User.fromJson(e as Map<String, dynamic>))
          .toList(),
      favoritesCount: json['favoritesCount'] as int?,
    )..expanded = json['expanded'] as bool?;

Map<String, dynamic> _$EntryToJson(Entry instance) => <String, dynamic>{
      'id': instance.id,
      'createdBy': instance.createdBy,
      'creationDate': instance.creationDate,
      'lastModifiedDate': instance.lastModifiedDate,
      'topic': instance.topic,
      'message': instance.message,
      'favorites': instance.favorites,
      'favoritesCount': instance.favoritesCount,
      'expanded': instance.expanded,
    };
