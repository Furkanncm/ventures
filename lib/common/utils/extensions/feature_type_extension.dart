import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/feature_type.dart';

extension FeatureTypeExtension on FeatureType {
  String get emptyHistoryMessage {
    switch (this) {
      case FeatureType.imageGeneration:
        return StringConstants.noImageHistory;
      case FeatureType.textToSpeech:
        return StringConstants.noAudioHistory;
      case FeatureType.documentAnalysis:
        return StringConstants.noDocumentHistory;
    }
  }

  IconData get icon {
    switch (this) {
      case FeatureType.imageGeneration:
        return Icons.image_not_supported_outlined;
      case FeatureType.textToSpeech:
        return Icons.mic_off_outlined;
      case FeatureType.documentAnalysis:
        return Icons.find_in_page_outlined;
    }
  }

  Color get color {
    switch (this) {
      case FeatureType.imageGeneration:
        return ColorName.primary;
      case FeatureType.textToSpeech:
        return ColorName.onSuccess;
      case FeatureType.documentAnalysis:
        return ColorName.tertiary;
    }
  }
}
