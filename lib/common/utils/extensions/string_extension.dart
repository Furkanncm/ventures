extension StringExtension on String? {
  bool get isNotNullOrNotEmpty => this != null && this!.trim().isNotEmpty;

  bool get isNullOrEmpty => this?.trim().isEmpty ?? true;
}
