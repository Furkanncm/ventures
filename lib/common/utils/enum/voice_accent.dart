import 'package:ventures/common/utils/constants/string_constants.dart';

enum VoiceAccent {
  american(StringConstants.accentAmerican),
  british(StringConstants.accentBritish),
  australian(StringConstants.accentAustralian),
  indian(StringConstants.accentIndian),
  african(StringConstants.accentAfrican),
  other(StringConstants.accentGeneral);

  const VoiceAccent(this.displayName);
  final String displayName;

  static VoiceAccent fromString(String? value) {
    if (value == null || value.isEmpty) return VoiceAccent.other;

    return switch (value.toLowerCase()) {
      'american' => VoiceAccent.american,
      'british' => VoiceAccent.british,
      'australian' => VoiceAccent.australian,
      'indian' => VoiceAccent.indian,
      'african' => VoiceAccent.african,
      _ => VoiceAccent.other,
    };
  }
}
