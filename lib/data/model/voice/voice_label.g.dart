// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'voice_label.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VoiceLabels _$VoiceLabelsFromJson(Map<String, dynamic> json) => VoiceLabels(
  accent: json['accent'] as String?,
  gender: json['gender'] as String?,
  age: json['age'] as String?,
  useCase: json['use_case'] as String?,
  language: json['language'] as String?,
);

Map<String, dynamic> _$VoiceLabelsToJson(VoiceLabels instance) =>
    <String, dynamic>{
      'accent': instance.accent,
      'gender': instance.gender,
      'age': instance.age,
      'use_case': instance.useCase,
      'language': instance.language,
    };
