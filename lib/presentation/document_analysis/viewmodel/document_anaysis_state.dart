import 'dart:typed_data';

import 'package:equatable/equatable.dart';

final class DocumentAnalysisState extends Equatable {
  const DocumentAnalysisState({
    this.isLoading = false,
    this.selectedBytes, 
    this.mimeType, 
    this.analysisResult,
    this.error,
    this.fileName,
  });

  factory DocumentAnalysisState.initial() {
    return const DocumentAnalysisState();
  }

  final bool isLoading;
  final Uint8List? selectedBytes;
  final String? mimeType; 
  final String? analysisResult;
  final String? error;
  final String? fileName;

  DocumentAnalysisState copyWith({
    bool? isLoading,
    Uint8List? selectedBytes,
    String? mimeType,
    String? analysisResult,
    String? fileName,
    String? error,
  }) {
    return DocumentAnalysisState(
      isLoading: isLoading ?? this.isLoading,
      selectedBytes: selectedBytes ?? this.selectedBytes,
      mimeType: mimeType ?? this.mimeType,
      analysisResult: analysisResult ?? this.analysisResult,
      fileName: fileName ?? this.fileName,
      error: error,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    selectedBytes,
    mimeType,
    analysisResult,
    error,
    fileName,
  ];
}
