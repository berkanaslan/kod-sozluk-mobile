// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'topic.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Topic _$TopicFromJson(Map<String, dynamic> json) => Topic(
      id: json['id'] as int?,
      name: json['name'] as String?,
      dailyTotalEntryCount: json['dailyTotalEntryCount'] as int?,
    );

Map<String, dynamic> _$TopicToJson(Topic instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'dailyTotalEntryCount': instance.dailyTotalEntryCount,
    };
