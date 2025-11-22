// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_analysis_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentAnalysisResponse _$DocumentAnalysisResponseFromJson(
  Map<String, dynamic> json,
) => DocumentAnalysisResponse(
  candidates: (json['candidates'] as List<dynamic>?)
      ?.map((e) => Candidate.fromJson(e as Map<String, dynamic>))
      .toList(),
  promptFeedback: json['promptFeedback'] == null
      ? null
      : PromptFeedback.fromJson(json['promptFeedback'] as Map<String, dynamic>),
);

Candidate _$CandidateFromJson(Map<String, dynamic> json) => Candidate(
  content: json['content'] == null
      ? null
      : ResponseContent.fromJson(json['content'] as Map<String, dynamic>),
  finishReason: json['finishReason'] as String?,
);

ResponseContent _$ResponseContentFromJson(Map<String, dynamic> json) =>
    ResponseContent(
      parts: (json['parts'] as List<dynamic>?)
          ?.map((e) => ResponsePart.fromJson(e as Map<String, dynamic>))
          .toList(),
      role: json['role'] as String?,
    );

ResponsePart _$ResponsePartFromJson(Map<String, dynamic> json) =>
    ResponsePart(text: json['text'] as String?);

PromptFeedback _$PromptFeedbackFromJson(Map<String, dynamic> json) =>
    PromptFeedback(blockReason: json['blockReason'] as String?);
