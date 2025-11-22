final class ApiConstants {
  ApiConstants._();

  static const String googleBaseUrl =
      'https://generativelanguage.googleapis.com';
  static const String apiVersion = 'v1beta';

  static const String geminiFlashModel = 'gemini-2.0-flash';

  static String getGeminiGenerateUrl({
    required String model,
    required String apiKey,
  }) {
    return '$googleBaseUrl/$apiVersion/models/$model:generateContent?key=$apiKey';
  }

  static const String elevenLabsBaseUrl =
      'https://api.elevenlabs.io/v1/text-to-speech';

  static String getElevenLabsUrl(String voiceId) {
    return '$elevenLabsBaseUrl/$voiceId';
  }
}
