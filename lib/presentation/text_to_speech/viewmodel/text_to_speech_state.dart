import 'package:equatable/equatable.dart';
import 'package:ventures/data/model/text_to_speech/audio_record.dart';
import 'package:ventures/data/model/voice/voice_model.dart';

final class TextToSpeechState extends Equatable {
  const TextToSpeechState({
    this.isLoading = false,
    this.audioRecord,
    this.errorMessage,
    this.voices = const [],
    this.selectedVoice,
  });

  factory TextToSpeechState.initial() {
    return const TextToSpeechState();
  }

  final bool isLoading;
  final AudioRecord? audioRecord;
  final String? errorMessage;
  final List<VoiceModel> voices;
  final VoiceModel? selectedVoice;

  TextToSpeechState copyWith({
    bool? isLoading,
    AudioRecord? audioRecord,
    String? errorMessage,
    List<VoiceModel>? voices,
    VoiceModel? selectedVoice,
  }) {
    return TextToSpeechState(
      isLoading: isLoading ?? this.isLoading,
      audioRecord: audioRecord ?? this.audioRecord,
      errorMessage: errorMessage,
      voices: voices ?? this.voices,
      selectedVoice: selectedVoice ?? this.selectedVoice,
    );
  }

  @override
  List<Object?> get props => [
    isLoading,
    audioRecord,
    errorMessage,
    voices,
    selectedVoice,
  ];
}
