import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:ventures/common/network/dio_manager.dart';
import 'package:ventures/common/utils/constants/api_constants.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/env_type.dart';
import 'package:ventures/common/utils/extensions/env_extension.dart';
import 'package:ventures/data/model/document_analysis/document_analysis_error.dart';
import 'package:ventures/data/model/document_analysis/document_analysis_request.dart';
import 'package:ventures/data/model/document_analysis/document_analysis_response.dart';

class DocumentRemoteDS {
  DocumentRemoteDS();

  final Dio _dio = DioManager().dio;

  Future<String> analyzeDocument({
    required Uint8List fileBytes,
    required String mimeType,
    required String prompt,
  }) async {
    final apiKey = EnvType.geminiApiKey.value;
    if (apiKey == null) {
      throw Exception(StringConstants.apiKeyNotFound);
    }

    final url = ApiConstants.getGeminiGenerateUrl(
      model: ApiConstants.geminiFlashModel,
      apiKey: apiKey,
    );

    final base64Data = base64Encode(fileBytes);

    final textPrompt = prompt.isEmpty
        ? StringConstants.defaultDocAnalysisPrompt
        : prompt;

    final requestModel = DocumentAnalysisRequest(
      contents: [
        Content(
          parts: [
            Part(text: textPrompt),
            Part(
              inlineData: InlineData(
                mimeType: mimeType,
                data: base64Data,
              ),
            ),
          ],
        ),
      ],
    );

    try {
      final response = await _dio.post(url, data: requestModel.toJson());

      if (response.statusCode == 200) {
        final responseData = response.data as Map<String, dynamic>;
        final responseModel = DocumentAnalysisResponse.fromJson(responseData);

        if (responseModel.candidates != null &&
            responseModel.candidates!.isNotEmpty) {
          final candidate = responseModel.candidates!.first;
          final parts = candidate.content?.parts;

          if (parts != null && parts.isNotEmpty) {
            return parts.first.text ?? '';
          }
        }

        if (responseModel.promptFeedback?.blockReason != null) {
          throw Exception(
            '${StringConstants.aiSafetyError} ${responseModel.promptFeedback?.blockReason}',
          );
        }

        throw Exception(StringConstants.apiEmptyResponse);
      } else {
        throw Exception('${StringConstants.apiError} ${response.statusCode}');
      }
    } on DioException catch (e) {
      var errorMsg = e.message ?? StringConstants.unknownConnectionError;

      if (e.response?.data != null) {
        try {
          final errorData = e.response!.data as Map<String, dynamic>;
          final errorModel = DocumentAnalysisError.fromJson(errorData);

          if (errorModel.error.message != null) {
            errorMsg = errorModel.error.message!;
          }
        } catch (_) {
          errorMsg = e.response?.data.toString() ?? errorMsg;
        }
      }

      throw Exception(
        '${StringConstants.connectionErrorPrefix} ${ApiConstants.geminiFlashModel}: $errorMsg',
      );
    } catch (e) {
      throw Exception('${StringConstants.unknownError} $e');
    }
  }
}
