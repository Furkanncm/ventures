import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'voice_label.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class VoiceLabels extends Equatable {
  const VoiceLabels({
    this.accent,
    this.gender,
    this.age,
    this.useCase,
    this.language,
  });

  factory VoiceLabels.fromJson(Map<String, dynamic> json) =>
      _$VoiceLabelsFromJson(json);

  final String? accent;
  final String? gender;
  final String? age;
  final String? useCase;
  final String? language;

  Map<String, dynamic> toJson() => _$VoiceLabelsToJson(this);

  @override
  List<Object?> get props => [accent, gender, age, useCase, language];
}
