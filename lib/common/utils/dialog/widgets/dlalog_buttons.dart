part of '../v_dialog.dart';

class _DialogButtons extends StatelessWidget {
  const _DialogButtons(
    this.negativeButtonLabel,
    this.positiveButtonLabel,
    this.onPositiveButton,
  );
  final String negativeButtonLabel;
  final String positiveButtonLabel;
  final VoidCallback onPositiveButton;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: VText(
              negativeButtonLabel,
              color: ColorName.primary,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: VElevatedButton(
            onPressed: () {
              onPositiveButton.call();
              Navigator.of(context).pop(true);
            },
            label: positiveButtonLabel,
          ),
        ),
      ],
    );
  }
}
