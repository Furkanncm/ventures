import 'package:equatable/equatable.dart';
import 'package:ventures/data/model/text_to_speech/audio_record.dart';

class TextToSpeechState extends Equatable {
  const TextToSpeechState({
    this.isLoading = false,
    this.audioRecord,
    this.errorMessage,
  });

  factory TextToSpeechState.initial() {
    return const TextToSpeechState();
  }

  final bool isLoading;
  final AudioRecord? audioRecord;
  final String? errorMessage;

  TextToSpeechState copyWith({
    bool? isLoading,
    AudioRecord? audioRecord,
    String? errorMessage,
  }) {
    return TextToSpeechState(
      isLoading: isLoading ?? this.isLoading,
      audioRecord: audioRecord ?? this.audioRecord,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object?> get props => [isLoading, audioRecord, errorMessage];
}
