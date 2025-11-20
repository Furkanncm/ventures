import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'audio_record.g.dart';

@JsonSerializable()
class AudioRecord extends Equatable {
  const AudioRecord({
    required this.id,
    required this.userId, // Constructor'a eklendi
    required this.filePath,
    required this.text,
    required this.createdAt,
  });

  factory AudioRecord.fromJson(Map<String, dynamic> json) =>
      _$AudioRecordFromJson(json);
  final String id;
  final String userId; // YENİ EKLENDİ: Kaydın sahibi kim?
  final String filePath;
  final String text;
  final DateTime createdAt;

  Map<String, dynamic> toJson() => _$AudioRecordToJson(this);

  @override
  List<Object?> get props => [id, userId, filePath, text, createdAt];

  // CopyWith metodunu da güncellemeyi unutma (Eğer varsa)
  AudioRecord copyWith({
    String? id,
    String? userId,
    String? filePath,
    String? text,
    DateTime? createdAt,
  }) {
    return AudioRecord(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      filePath: filePath ?? this.filePath,
      text: text ?? this.text,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}
