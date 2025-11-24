part of '../splash_view.dart';

@immutable
final class _SplashLoading extends StatefulWidget {
  const _SplashLoading({required this.fadeAnimation});

  final Animation<double> fadeAnimation;

  @override
  State<_SplashLoading> createState() => _SplashLoadingState();
}

class _SplashLoadingState extends State<_SplashLoading>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 0.4, end: 1).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: widget.fadeAnimation,
      child: FadeTransition(
        opacity: _pulseAnimation,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(3, (index) {
                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 8,
                  height: 8,
                  decoration: const BoxDecoration(
                    color: ColorName.primary,
                    shape: BoxShape.circle,
                  ),
                );
              }),
            ),

            VSizedBox.verticalBox12,

            const VText(
              StringConstants.initializingAi,
              type: VTextStyleType.bodySmall,
            ),
          ],
        ),
      ),
    );
  }
}
