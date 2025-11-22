import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'document_analysis_response.g.dart';

@JsonSerializable(createToJson: false) // Sadece veriyi okuyacağız (fromJson)
class DocumentAnalysisResponse extends Equatable {
  const DocumentAnalysisResponse({
    this.candidates,
    this.promptFeedback,
  });

  factory DocumentAnalysisResponse.fromJson(Map<String, dynamic> json) =>
      _$DocumentAnalysisResponseFromJson(json);

  final List<Candidate>? candidates;
  final PromptFeedback? promptFeedback;

  @override
  List<Object?> get props => [candidates, promptFeedback];
}

@JsonSerializable(createToJson: false)
class Candidate extends Equatable {
  const Candidate({
    this.content,
    this.finishReason,
  });

  factory Candidate.fromJson(Map<String, dynamic> json) =>
      _$CandidateFromJson(json);

  final ResponseContent? content;
  final String? finishReason;

  @override
  List<Object?> get props => [content, finishReason];
}

@JsonSerializable(createToJson: false)
class ResponseContent extends Equatable {
  const ResponseContent({
    this.parts,
    this.role,
  });

  factory ResponseContent.fromJson(Map<String, dynamic> json) =>
      _$ResponseContentFromJson(json);

  final List<ResponsePart>? parts;
  final String? role;

  @override
  List<Object?> get props => [parts, role];
}

@JsonSerializable(createToJson: false)
class ResponsePart extends Equatable {
  const ResponsePart({
    this.text,
  });

  factory ResponsePart.fromJson(Map<String, dynamic> json) =>
      _$ResponsePartFromJson(json);

  final String? text;

  @override
  List<Object?> get props => [text];
}

@JsonSerializable(createToJson: false)
class PromptFeedback extends Equatable {
  const PromptFeedback({
    this.blockReason,
  });

  factory PromptFeedback.fromJson(Map<String, dynamic> json) =>
      _$PromptFeedbackFromJson(json);

  final String? blockReason;

  @override
  List<Object?> get props => [blockReason];
}
