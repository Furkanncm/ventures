part of '../text_to_speech_view.dart';

@immutable
final class _TTSActionButton extends ConsumerWidget {
  const _TTSActionButton({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return VElevatedButton.withIconAndFullWith(
      onPressed: onTap,
      icon: const Icon(Icons.record_voice_over),
      label: StringConstants.convertToSpeech,
    );
  }
}
