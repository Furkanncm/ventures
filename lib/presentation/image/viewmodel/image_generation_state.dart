
import 'dart:io';
import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class ImageGenerationState extends Equatable {
  const ImageGenerationState({
     this.loading=false,
    this.imageUrl,
    this.error,
    this.imageFile,
  });
  final bool loading;
  final Uint8List? imageUrl;
  final String? error;
  final File? imageFile;

  ImageGenerationState copyWith({
    bool? loading,
    Uint8List? imageUrl,
    String? error,
    File? imageFile,
  }) => ImageGenerationState(
    loading: loading ?? this.loading,
    imageUrl: imageUrl ?? this.imageUrl,
    error: error ?? this.error,
    imageFile: imageFile??this.imageFile
  );

  @override
  List<Object?> get props => [loading, imageUrl, error,imageFile];
}
