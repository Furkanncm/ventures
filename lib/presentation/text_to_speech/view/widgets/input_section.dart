part of '../text_to_speech_view.dart';

@immutable
final class _TTSInputSection extends StatelessWidget {
  const _TTSInputSection({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return InputCard(
      controller: controller,
      maxLines: 6,
    );
  }
}
