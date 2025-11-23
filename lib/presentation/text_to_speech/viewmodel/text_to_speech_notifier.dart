import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart'; // Legacy kullanıyorsan
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/feature_type.dart';
import 'package:ventures/data/model/text_to_speech/text_to_speech_request.dart';
import 'package:ventures/data/model/voice/voice_model.dart'; // Import
import 'package:ventures/domain/history/history_repository.dart';
import 'package:ventures/domain/text_to_speech/text_to_speech_repository.dart';
import 'package:ventures/presentation/text_to_speech/viewmodel/text_to_speech_state.dart';

class TextToSpeechNotifier extends StateNotifier<TextToSpeechState> {
  TextToSpeechNotifier(
    this._ref,
    this._repository,
    this._historyRepository,
  ) : super(TextToSpeechState.initial()) {
    _loadVoices();
  }

  final Ref _ref;
  final ITextToSpeechRepository _repository;
  final IHistoryRepository _historyRepository;

  Future<void> _loadVoices() async {
    state = state.copyWith(isLoading: true);
    final voices = await _repository.getVoices();

    if (voices.isNotEmpty) {
      state = state.copyWith(
        voices: voices,
        selectedVoice: voices.first,
      );
    }
    state = state.copyWith(isLoading: false);
  }

  void selectVoice(VoiceModel voice) {
    state = state.copyWith(selectedVoice: voice);
  }

  Future<void> convertTextToSpeech({
    required String text,
  }) async {
    final userState = _ref.read(profileNotifierProvider);
    final user = userState.user;

    if (user == null || user.uid == null) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: StringConstants.errorUserNotFound,
      );
      return;
    }

    if (!user.hasCredit(FeatureType.textToSpeech)) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: StringConstants.freeLimitReached,
      );
      return;
    }

    state = state.copyWith(isLoading: true);

    final currentVoiceId =
        state.selectedVoice?.voiceId ?? StringConstants.defaultVoice;

    final request = TextToSpeechRequest(
      text: text,
      voiceId: currentVoiceId,
    );

    final bytes = await _repository.getSpeechAudio(request);

    if (bytes != null) {
      final record = await _historyRepository.saveRecord(
        bytes: bytes,
        text: text,
      );

      unawaited(
        _ref
            .read(profileNotifierProvider.notifier)
            .incrementLocalUsage(FeatureType.textToSpeech),
      );

      state = state.copyWith(
        isLoading: false,
        audioRecord: record,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        errorMessage: StringConstants.audioDataNullError,
      );
    }
  }

  Future<void> reset() async {
    state = TextToSpeechState.initial();
    await _loadVoices();
  }
}
