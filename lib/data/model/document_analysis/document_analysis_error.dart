import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'document_analysis_error.g.dart';

@JsonSerializable(createToJson: false) // Sadece okuyacağız (fromJson)
class DocumentAnalysisError extends Equatable {
  const DocumentAnalysisError({
    required this.error,
  });

  factory DocumentAnalysisError.fromJson(Map<String, dynamic> json) =>
      _$DocumentAnalysisErrorFromJson(json);

  final ApiError error;

  @override
  List<Object?> get props => [error];
}

@JsonSerializable(createToJson: false)
class ApiError extends Equatable {
  const ApiError({
    this.code,
    this.message,
    this.status,
  });

  factory ApiError.fromJson(Map<String, dynamic> json) =>
      _$ApiErrorFromJson(json);

  final int? code;
  final String? message;
  final String? status;

  @override
  List<Object?> get props => [code, message, status];
}
