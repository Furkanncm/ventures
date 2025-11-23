import 'dart:convert';
import 'dart:typed_data';

import 'package:ventures/common/utils/enum/share_prefs_keys.dart';
import 'package:ventures/data/data_source/remote/text_to_speech_remote_ds.dart';
import 'package:ventures/data/model/text_to_speech/text_to_speech_request.dart';
import 'package:ventures/data/model/voice/voice_model.dart';
import 'package:ventures/domain/shared_pref/share_pref_manager.dart'; // Import

abstract class ITextToSpeechRepository {
  Future<Uint8List?> getSpeechAudio(TextToSpeechRequest request);

  Future<List<VoiceModel>> getVoices();
}

class TextToSpeechRepository implements ITextToSpeechRepository {
  TextToSpeechRepository({TextToSpeechRemoteDS? service})
    : _service = service ?? TextToSpeechRemoteDS();

  final TextToSpeechRemoteDS _service;
  final SharedPrefsManager _prefsManager = SharedPrefsManager();

  @override
  Future<Uint8List?> getSpeechAudio(TextToSpeechRequest request) async {
    final audioBytes = await _service.createSpeech(request);
    return audioBytes;
  }

  @override
  Future<List<VoiceModel>> getVoices() async {
    final cachedString = _prefsManager.getString(SharedPrefsKeys.voiceList);

    if (cachedString != null && cachedString.isNotEmpty) {
      final decodedList = jsonDecode(cachedString) as List;
      return decodedList
          .cast<Map<String, dynamic>>()
          .map(VoiceModel.fromJson)
          .toList();
    }

    final voices = await _service.getVoices();
    if (voices.isNotEmpty) {
      final jsonString = jsonEncode(voices.map((e) => e.toJson()).toList());
      await _prefsManager.setString(SharedPrefsKeys.voiceList, jsonString);
    }

    return voices;
  }
}
