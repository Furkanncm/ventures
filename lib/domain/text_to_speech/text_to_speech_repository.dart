import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:ventures/data/data_source/remote/text_to_speech_remote_ds.dart';
import 'package:ventures/data/model/text_to_speech/text_to_speech_request.dart';

abstract class ITextToSpeechRepository {
  Future<Uint8List?> getSpeechAudio(TextToSpeechRequest request);
}

class TextToSpeechRepository implements ITextToSpeechRepository {
  TextToSpeechRepository({TextToSpeechRemoteDS? service})
    : _service = service ?? TextToSpeechRemoteDS();
  final TextToSpeechRemoteDS _service;

  @override
  Future<Uint8List?> getSpeechAudio(TextToSpeechRequest request) async {
    try {
      final audioBytes = await _service.createSpeech(request);
      return audioBytes;
    } catch (e) {
      debugPrint('Repository Error (ElevenLabs): $e');
      rethrow;
    }
  }
}
