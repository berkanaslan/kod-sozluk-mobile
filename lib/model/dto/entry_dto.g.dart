// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'entry_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EntryDTO _$EntryDTOFromJson(Map<String, dynamic> json) => EntryDTO(
      id: json['id'] as int?,
      message: json['message'] as String,
      topic: Topic.fromJson(json['topic'] as Map<String, dynamic>),
      author: User.fromJson(json['author'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$EntryDTOToJson(EntryDTO instance) => <String, dynamic>{
      'id': instance.id,
      'message': instance.message,
      'topic': instance.topic,
      'author': instance.author,
    };
