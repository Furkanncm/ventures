// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'text_to_speech_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TextToSpeechRequest _$TextToSpeechRequestFromJson(Map<String, dynamic> json) =>
    TextToSpeechRequest(
      text: json['text'] as String,
      modelId: json['model_id'] as String? ?? 'eleven_multilingual_v2',
      voiceId: json['voice_id'] as String? ?? '21m00Tcm4TlvDq8ikWAM',
      voiceSettings: json['voice_settings'] == null
          ? const ElevenLabsVoiceSettings()
          : ElevenLabsVoiceSettings.fromJson(
              json['voice_settings'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$TextToSpeechRequestToJson(
  TextToSpeechRequest instance,
) => <String, dynamic>{
  'text': instance.text,
  'model_id': instance.modelId,
  'voice_settings': instance.voiceSettings,
};

ElevenLabsVoiceSettings _$ElevenLabsVoiceSettingsFromJson(
  Map<String, dynamic> json,
) => ElevenLabsVoiceSettings(
  stability: (json['stability'] as num?)?.toDouble() ?? 0.5,
  similarityBoost: (json['similarity_boost'] as num?)?.toDouble() ?? 0.5,
);

Map<String, dynamic> _$ElevenLabsVoiceSettingsToJson(
  ElevenLabsVoiceSettings instance,
) => <String, dynamic>{
  'stability': instance.stability,
  'similarity_boost': instance.similarityBoost,
};
