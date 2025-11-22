import 'package:json_annotation/json_annotation.dart';

part 'document_analysis_record.g.dart';

@JsonSerializable()
class DocumentAnalysisRecord {
  DocumentAnalysisRecord({
    required this.id,
    required this.userId,
    required this.resultText,
    required this.createdAt,
    this.imagePath,
    this.fileName, // YENİ: Dosya Adı
  });

  factory DocumentAnalysisRecord.fromJson(Map<String, dynamic> json) =>
      _$DocumentAnalysisRecordFromJson(json);

  final String id;
  final String userId;
  final String resultText;
  final DateTime createdAt;
  final String? imagePath;
  final String? fileName; // YENİ

  Map<String, dynamic> toJson() => _$DocumentAnalysisRecordToJson(this);
}
