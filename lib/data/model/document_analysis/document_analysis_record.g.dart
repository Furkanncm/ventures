// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_analysis_record.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentAnalysisRecord _$DocumentAnalysisRecordFromJson(
  Map<String, dynamic> json,
) => DocumentAnalysisRecord(
  id: json['id'] as String,
  userId: json['userId'] as String,
  resultText: json['resultText'] as String,
  createdAt: DateTime.parse(json['createdAt'] as String),
  imagePath: json['imagePath'] as String?,
  fileName: json['fileName'] as String?,
);

Map<String, dynamic> _$DocumentAnalysisRecordToJson(
  DocumentAnalysisRecord instance,
) => <String, dynamic>{
  'id': instance.id,
  'userId': instance.userId,
  'resultText': instance.resultText,
  'createdAt': instance.createdAt.toIso8601String(),
  'imagePath': instance.imagePath,
  'fileName': instance.fileName,
};
