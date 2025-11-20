// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AudioRecord _$AudioRecordFromJson(Map<String, dynamic> json) => AudioRecord(
  id: json['id'] as String,
  filePath: json['filePath'] as String,
  text: json['text'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$AudioRecordToJson(AudioRecord instance) =>
    <String, dynamic>{
      'id': instance.id,
      'filePath': instance.filePath,
      'text': instance.text,
      'createdAt': instance.createdAt.toIso8601String(),
    };
