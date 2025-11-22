part of '../v_bottom_sheets.dart';

@immutable
final class _SheetHeader extends StatelessWidget {
  const _SheetHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 16),
      child: VFaddedText(
        text: title,
        textStyleType: VTextStyleType.titleMedium,
      ),
    );
  }
}
