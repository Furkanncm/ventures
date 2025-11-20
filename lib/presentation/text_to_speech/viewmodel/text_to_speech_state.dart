import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class TextToSpeechState extends Equatable {
  const TextToSpeechState({
    this.isLoading = false,
    this.audioBytes,
    this.errorMessage,
  });

  factory TextToSpeechState.initial() {
    return const TextToSpeechState();
  }
  final bool isLoading;
  final Uint8List? audioBytes;
  final String? errorMessage;

  TextToSpeechState copyWith({
    bool? isLoading,
    Uint8List? audioBytes,
    String? errorMessage,
  }) {
    return TextToSpeechState(
      isLoading: isLoading ?? this.isLoading,
      audioBytes: audioBytes ?? this.audioBytes,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, audioBytes, errorMessage];
}
