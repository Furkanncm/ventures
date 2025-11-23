// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoiceModel _$VoiceModelFromJson(Map<String, dynamic> json) => VoiceModel(
  voiceId: json['voice_id'] as String,
  name: json['name'] as String,
  category: json['category'] as String?,
  description: json['description'] as String?,
  previewUrl: json['preview_url'] as String?,
  labels: json['labels'] == null
      ? null
      : VoiceLabels.fromJson(json['labels'] as Map<String, dynamic>),
);

Map<String, dynamic> _$VoiceModelToJson(VoiceModel instance) =>
    <String, dynamic>{
      'voice_id': instance.voiceId,
      'name': instance.name,
      'category': instance.category,
      'description': instance.description,
      'preview_url': instance.previewUrl,
      'labels': instance.labels,
    };
