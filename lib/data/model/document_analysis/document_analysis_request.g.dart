// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'document_analysis_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DocumentAnalysisRequest _$DocumentAnalysisRequestFromJson(
  Map<String, dynamic> json,
) => DocumentAnalysisRequest(
  contents: (json['contents'] as List<dynamic>)
      .map((e) => Content.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DocumentAnalysisRequestToJson(
  DocumentAnalysisRequest instance,
) => <String, dynamic>{
  'contents': instance.contents.map((e) => e.toJson()).toList(),
};

Content _$ContentFromJson(Map<String, dynamic> json) => Content(
  parts: (json['parts'] as List<dynamic>)
      .map((e) => Part.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
  'parts': instance.parts.map((e) => e.toJson()).toList(),
};

Part _$PartFromJson(Map<String, dynamic> json) => Part(
  text: json['text'] as String?,
  inlineData: json['inline_data'] == null
      ? null
      : InlineData.fromJson(json['inline_data'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PartToJson(Part instance) => <String, dynamic>{
  'text': ?instance.text,
  'inline_data': ?instance.inlineData?.toJson(),
};

InlineData _$InlineDataFromJson(Map<String, dynamic> json) => InlineData(
  mimeType: json['mime_type'] as String,
  data: json['data'] as String,
);

Map<String, dynamic> _$InlineDataToJson(InlineData instance) =>
    <String, dynamic>{'mime_type': instance.mimeType, 'data': instance.data};
