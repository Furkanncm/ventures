import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';
import 'package:stability_image_generation/stability_image_generation.dart';

class ImageGenerationState extends Equatable {
  const ImageGenerationState({
    this.loading = false,
    this.imageUrl,
    this.error,
    this.imageFile,
    this.selectedStyle = ImageAIStyle.noStyle,
  });
  final bool loading;
  final Uint8List? imageUrl;
  final String? error;
  final File? imageFile;
  final ImageAIStyle selectedStyle;

  ImageGenerationState copyWith({
    bool? loading,
    Uint8List? imageUrl,
    String? error,
    File? imageFile,
    ImageAIStyle? selectedStyle,
  }) => ImageGenerationState(
    loading: loading ?? this.loading,
    imageUrl: imageUrl ?? this.imageUrl,
    error: error ?? this.error,
    imageFile: imageFile ?? this.imageFile,
    selectedStyle: selectedStyle ?? this.selectedStyle,
  );

  @override
  List<Object?> get props => [
    loading,
    imageUrl,
    error,
    imageFile,
    selectedStyle,
  ];
}
