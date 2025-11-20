import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'audio_record.g.dart';

@JsonSerializable()
class AudioRecord extends Equatable {
  const AudioRecord({
    required this.id,
    required this.filePath,
    required this.text,
    required this.createdAt,
  });

  factory AudioRecord.fromJson(Map<String, dynamic> json) =>
      _$AudioRecordFromJson(json);
  final String id;
  final String filePath;
  final String text;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => _$AudioRecordToJson(this);

  AudioRecord copyWith({
    String? id,
    String? filePath,
    String? text,
    DateTime? createdAt,
  }) {
    return AudioRecord(
      id: id ?? this.id,
      filePath: filePath ?? this.filePath,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  List<Object?> get props => [id, filePath, text, createdAt];
}
