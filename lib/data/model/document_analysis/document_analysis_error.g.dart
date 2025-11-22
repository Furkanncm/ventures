// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_analysis_error.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentAnalysisError _$DocumentAnalysisErrorFromJson(
  Map<String, dynamic> json,
) => DocumentAnalysisError(
  error: ApiError.fromJson(json['error'] as Map<String, dynamic>),
);

ApiError _$ApiErrorFromJson(Map<String, dynamic> json) => ApiError(
  code: (json['code'] as num?)?.toInt(),
  message: json['message'] as String?,
  status: json['status'] as String?,
);
