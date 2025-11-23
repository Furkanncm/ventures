import 'package:google_generative_ai/google_generative_ai.dart';
import 'package:ventures/common/utils/constants/api_constants.dart'; // Import Eklendi
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/env_type.dart';
import 'package:ventures/common/utils/extensions/env_extension.dart';

class ChatRemoteDS {
  ChatRemoteDS() {
    _initChat();
  }

  late final GenerativeModel _model;
  late final ChatSession _chatSession;

  void _initChat() {
    final apiKey = EnvType.geminiApiKey.value;
    if (apiKey == null) throw Exception(StringConstants.aiApiKeyNotFound);

    _model = GenerativeModel(
      model: ApiConstants.geminiFlashModel,
      apiKey: apiKey,
      systemInstruction: Content.system(StringConstants.aiSystemInstruction),
    );

    _chatSession = _model.startChat();
  }

  Future<String> sendMessage(String message) async {
    try {
      final response = await _chatSession.sendMessage(Content.text(message));
      return response.text ?? StringConstants.aiUnknownResponse;
    } catch (e) {
      throw Exception('${StringConstants.aiErrorPrefix} $e');
    }
  }
}
