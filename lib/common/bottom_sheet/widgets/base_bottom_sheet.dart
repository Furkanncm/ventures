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
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        // Köşeleri daha yumuşak yaptık
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // --- DRAG HANDLE (Tutma Çubuğu) ---
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 12, bottom: 8),
                width: 48,
                height: 5,
                decoration: BoxDecoration(
                  color: Colors.grey.withValues(alpha: 0.3),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            // ----------------------------------
            Padding(
              padding: const EdgeInsets.only(bottom: 24),
              child: child,
            ),
          ],
        ),
      ),
    );
  }
}