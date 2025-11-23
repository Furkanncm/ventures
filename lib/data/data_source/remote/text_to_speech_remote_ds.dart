import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:ventures/common/network/dio_manager.dart';
import 'package:ventures/common/utils/constants/api_constants.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/env_type.dart';
import 'package:ventures/common/utils/extensions/env_extension.dart';
import 'package:ventures/common/utils/extensions/string_extension.dart';
import 'package:ventures/data/model/text_to_speech/text_to_speech_request.dart';
import 'package:ventures/data/model/voice/voice_model.dart';

class TextToSpeechRemoteDS {
  static final String? _elevenLabsApiKey = EnvType.eventlabApiKey.value;

  final Dio dio = DioManager().dio;

  Future<Uint8List?> createSpeech(TextToSpeechRequest request) async {
    if (_elevenLabsApiKey.isNullOrEmpty) {
      throw Exception(StringConstants.apiKeyNotFound);
    }

    final url = ApiConstants.getElevenLabsUrl(request.voiceId);

    final response = await dio.post(
      url,
      data: request.toJson(),
      options: Options(
        responseType: ResponseType.bytes,
        headers: {
          'xi-api-key': _elevenLabsApiKey,
          'Content-Type': 'application/json',
        },
      ),
    );

    if (response.statusCode == 200) {
      return Uint8List.fromList(List<int>.from(response.data as List));
    }

    return null;
  }

  Future<List<VoiceModel>> getVoices() async {
    if (_elevenLabsApiKey.isNullOrEmpty) {
      throw Exception(StringConstants.apiKeyNotFound);
    }

    const url = ApiConstants.elevenLabsVoicesUrl;

    final response = await dio.get(
      url,
      options: Options(
        headers: {
          'xi-api-key': _elevenLabsApiKey,
        },
      ),
    );

    if (response.statusCode == 200) {
      final voicesData = response.data['voices'] as List;

      return voicesData
          .map((e) => VoiceModel.fromJson(e as Map<String, dynamic>))
          .toList();
    }

    return [];
  }
}
