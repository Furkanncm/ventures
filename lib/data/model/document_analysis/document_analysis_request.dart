import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'document_analysis_request.g.dart';

@JsonSerializable(explicitToJson: true)
class DocumentAnalysisRequest extends Equatable {
  const DocumentAnalysisRequest({
    required this.contents,
  });

  factory DocumentAnalysisRequest.fromJson(Map<String, dynamic> json) =>
      _$DocumentAnalysisRequestFromJson(json);

  final List<Content> contents;

  Map<String, dynamic> toJson() => _$DocumentAnalysisRequestToJson(this);

  @override
  List<Object?> get props => [contents];
}

@JsonSerializable(explicitToJson: true)
class Content extends Equatable {
  const Content({
    required this.parts,
  });

  factory Content.fromJson(Map<String, dynamic> json) =>
      _$ContentFromJson(json);

  final List<Part> parts;

  Map<String, dynamic> toJson() => _$ContentToJson(this);

  @override
  List<Object?> get props => [parts];
}

@JsonSerializable(explicitToJson: true, includeIfNull: false)
class Part extends Equatable {
  const Part({
    this.text,
    this.inlineData,
  });

  factory Part.fromJson(Map<String, dynamic> json) => _$PartFromJson(json);

  final String? text;

  @JsonKey(name: 'inline_data')
  final InlineData? inlineData;

  Map<String, dynamic> toJson() => _$PartToJson(this);

  @override
  List<Object?> get props => [text, inlineData];
}

@JsonSerializable(explicitToJson: true)
class InlineData extends Equatable {
  const InlineData({
    required this.mimeType,
    required this.data,
  });

  factory InlineData.fromJson(Map<String, dynamic> json) =>
      _$InlineDataFromJson(json);

  @JsonKey(name: 'mime_type')
  final String mimeType;

  // Base64 encoded string
  final String data;

  Map<String, dynamic> toJson() => _$InlineDataToJson(this);

  @override
  List<Object?> get props => [mimeType, data];
}
