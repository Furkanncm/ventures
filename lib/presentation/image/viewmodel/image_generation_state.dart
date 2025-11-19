import 'dart:typed_data';

class ImageGenerationState {
  ImageGenerationState({this.loading = false, this.imageUrl, this.error});
  final bool loading;
  final Uint8List? imageUrl;
  final String? error;

  ImageGenerationState copyWith({
    bool? loading,
    Uint8List? imageUrl,
    String? error,
  }) => ImageGenerationState(
    loading: loading ?? this.loading,
    imageUrl: imageUrl ?? this.imageUrl,
    error: error ?? this.error,
  );
}
