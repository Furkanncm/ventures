part of '../v_bottom_sheets.dart';

@immutable
final class _SheetOption extends StatelessWidget {
  const _SheetOption({
    required this.icon,
    required this.title,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        splashColor: ColorName.primary.withValues(alpha: 0.1),
        child: Padding(
          padding: VPadding.all(),
          child: Row(
            children: [
              Container(
                padding: VPadding.all() / 2,
                decoration: BoxDecoration(
                  color: ColorName.primary.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(icon, color: ColorName.primary),
              ),

              VSizedBox.horizontalBox16,

              Expanded(child: VText(title, type: VTextStyleType.bodyLarge)),
              Icon(
                Icons.chevron_right_rounded,
                color: ColorName.gray.withValues(alpha: 0.5),
                size: 20,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
