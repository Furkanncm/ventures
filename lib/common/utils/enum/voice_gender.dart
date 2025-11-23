enum VoiceGender {
  male,
  female,
  unknown;

  static VoiceGender fromString(String? value) {
    return switch (value?.toLowerCase()) {
      'male' => VoiceGender.male,
      'female' => VoiceGender.female,
      _ => VoiceGender.unknown,
    };
  }

  bool get isFemale => this == VoiceGender.female;
  bool get isMale => this == VoiceGender.male;
}
