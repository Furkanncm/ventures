import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:ventures/common/network/dio_manager.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/env_type.dart';
import 'package:ventures/common/utils/extensions/env_extension.dart';
import 'package:ventures/common/utils/extensions/string_extension.dart';
import 'package:ventures/data/model/text_to_speech/text_to_speech_request.dart';

class TextToSpeechRemoteDS {
  static final String? _elevenLabsApiKey = EnvType.eventlabApiKey.value;

  Future<Uint8List?> createSpeech(TextToSpeechRequest request) async {
    if (_elevenLabsApiKey.isNullOrEmpty) {
      throw Exception('Eventlab API key not found');
    }

    try {
      final dio = DioManager().dio;

      final response = await dio.post(
        '${StringConstants.eventlabBaseUrl}${request.voiceId}',

        data: request.toJson(),

        options: Options(
          responseType: ResponseType.bytes,
          headers: {
            'xi-api-key': _elevenLabsApiKey,
          },
        ),
      );

      if (response.statusCode == 200) {
        return Uint8List.fromList(List<int>.from(response.data as List));
      }

      return null;
    } on DioException catch (e) {
      debugPrint('ElevenLabs API Hatası: ${e.response?.statusCode}');
      return null;
    } catch (e) {
      debugPrint('${StringConstants.errorGeneric} $e');
      return null;
    }
  }
}
