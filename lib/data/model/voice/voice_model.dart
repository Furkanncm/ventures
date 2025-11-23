import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:ventures/common/utils/enum/voice_accent.dart';
import 'package:ventures/common/utils/enum/voice_gender.dart';
import 'package:ventures/data/model/voice/voice_label.dart'; 

part 'voice_model.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class VoiceModel extends Equatable {
  const VoiceModel({
    required this.voiceId,
    required this.name,
    this.category,
    this.description, 
    this.previewUrl,
    this.labels, 
  });

  factory VoiceModel.fromJson(Map<String, dynamic> json) =>
      _$VoiceModelFromJson(json);

  final String voiceId;
  final String name;
  final String? category;
  final String? description; 
  final String? previewUrl;
  final VoiceLabels? labels; 

  Map<String, dynamic> toJson() => _$VoiceModelToJson(this);

  VoiceGender get gender => VoiceGender.fromString(labels?.gender);

  VoiceAccent get accentEnum => VoiceAccent.fromString(labels?.accent);


  bool get isFemale => gender.isFemale;

  String get displayDescription => description ?? labels?.useCase ?? '';

  @override
  List<Object?> get props => [
    voiceId,
    name,
    category,
    description,
    previewUrl,
    labels,
  ];
}
