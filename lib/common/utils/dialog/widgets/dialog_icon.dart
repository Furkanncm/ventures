part of '../v_dialog.dart';

@immutable
final class _DialogIcon extends StatelessWidget {
  const _DialogIcon();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 75,
      height: 75,
      decoration: BoxDecoration(
        color: ColorName.backgroundLight,
        shape: BoxShape.circle,
        border: Border.all(
          color: ColorName.primary,
          width: 4,
        ),
      ),
      child: const Icon(
        Icons.question_mark_rounded,
        color: ColorName.primary,
        size: 40,
      ),
    );
  }
}
