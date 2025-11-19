part of '../v_dialog.dart';

class _BaseDialog extends StatelessWidget {
  const _BaseDialog({
    required this.title,
    required this.content,
    required this.onPositiveButton,
    required this.negativeButtonLabel,
    required this.positiveButtonLabel,
  });
  final String title;
  final String content;
  final VoidCallback onPositiveButton;
  final String negativeButtonLabel;
  final String positiveButtonLabel;

  @override
  Widget build(BuildContext context) {
    return AlertDialog.adaptive(
      icon: const _DialogIcon(),
      title: Center(
        child: VText(
          title,
          type: VTextStyleType.titleMedium,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: VText(
        content,
        type: VTextStyleType.titleSmall,
        maxLines: 3,
      ),
      actions: [
        _DialogButtons(
          negativeButtonLabel,
          positiveButtonLabel,
          onPositiveButton,
        ),
      ],
    );
  }
}
