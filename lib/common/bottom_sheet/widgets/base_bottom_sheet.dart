part of '../v_bottom_sheets.dart';

@immutable
final class VBaseBottomSheet extends StatelessWidget {
  const VBaseBottomSheet({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: ColorName.backgroundLight,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 48,
                height: 5,
                decoration: BoxDecoration(
                  color: ColorName.gray.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            // ----------------------------------
            Flexible(
              child: Padding(
                padding: const VPadding.onlyBottomPadding() * 2,
                child: child,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
