import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'text_to_speech_request.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, includeIfNull: false)
class TextToSpeechRequest extends Equatable {
  const TextToSpeechRequest({
    required this.text,
    this.modelId = 'eleven_multilingual_v2',
    this.voiceId = '21m00Tcm4TlvDq8ikWAM', // Default: Rachel
    this.voiceSettings = const ElevenLabsVoiceSettings(),
  });

  factory TextToSpeechRequest.fromJson(Map<String, dynamic> json) =>
      _$TextToSpeechRequestFromJson(json);
  final String text;

  @JsonKey(name: 'model_id')
  final String modelId;
  @JsonKey(includeToJson: false)
  final String voiceId;

  final ElevenLabsVoiceSettings voiceSettings;

  Map<String, dynamic> toJson() => _$TextToSpeechRequestToJson(this);

  TextToSpeechRequest copyWith({
    String? text,
    String? modelId,
    String? voiceId,
    ElevenLabsVoiceSettings? voiceSettings,
  }) {
    return TextToSpeechRequest(
      text: text ?? this.text,
      modelId: modelId ?? this.modelId,
      voiceId: voiceId ?? this.voiceId,
      voiceSettings: voiceSettings ?? this.voiceSettings,
    );
  }

  @override
  List<Object?> get props => [text, modelId, voiceId, voiceSettings];
}

@JsonSerializable(fieldRename: FieldRename.snake)
class ElevenLabsVoiceSettings extends Equatable {
  const ElevenLabsVoiceSettings({
    this.stability = 0.5,
    this.similarityBoost = 0.5,
  });

  factory ElevenLabsVoiceSettings.fromJson(Map<String, dynamic> json) =>
      _$ElevenLabsVoiceSettingsFromJson(json);
  final double stability;
  final double similarityBoost;

  Map<String, dynamic> toJson() => _$ElevenLabsVoiceSettingsToJson(this);

  ElevenLabsVoiceSettings copyWith({
    double? stability,
    double? similarityBoost,
  }) {
    return ElevenLabsVoiceSettings(
      stability: stability ?? this.stability,
      similarityBoost: similarityBoost ?? this.similarityBoost,
    );
  }

  @override
  List<Object?> get props => [stability, similarityBoost];
}
