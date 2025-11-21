import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/feature_type.dart';
import 'package:ventures/data/model/text_to_speech/text_to_speech_request.dart';
import 'package:ventures/domain/audio_record/audio_record_repository.dart';
import 'package:ventures/domain/text_to_speech/text_to_speech_repository.dart';
import 'package:ventures/domain/user/user_repository.dart';
import 'package:ventures/presentation/text_to_speech/viewmodel/text_to_speech_state.dart';

class TextToSpeechNotifier extends StateNotifier<TextToSpeechState> {
  TextToSpeechNotifier(
    this._ref,
    this._repository,
    this._historyRepository,
    this._userRepository,
  ) : super(TextToSpeechState.initial());

  final Ref _ref;
  final TextToSpeechRepository _repository;
  final IHistoryRepository _historyRepository;
  final IUserRepository _userRepository;

  Future<void> convertTextToSpeech({
    required String text,
    String voiceId = '21m00Tcm4TlvDq8ikWAM',
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

    try {
      final request = TextToSpeechRequest(
        text: text,
        voiceId: voiceId,
      );

      final bytes = await _repository.getSpeechAudio(request);

      if (bytes != null) {
        final record = await _historyRepository.saveRecord(
          bytes: bytes,
          text: text,
        );

        await _userRepository.incrementUsage(
          user.uid!,
          FeatureType.textToSpeech,
        );
        _ref
            .read(profileNotifierProvider.notifier)
            .incrementLocalUsage(FeatureType.textToSpeech);

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
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
    }
  }

  void reset() {
    state = TextToSpeechState.initial();
  }
}
