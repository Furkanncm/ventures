part of '../splash_view.dart';

@immutable
final class _SplashContent extends StatelessWidget {
  const _SplashContent({
    required this.fadeAnimation,
    required this.slideAnimation,
    required this.scaleAnimation,
    required this.floatingAnimation,
  });

  final Animation<double> fadeAnimation;
  final Animation<Offset> slideAnimation;
  final Animation<double> scaleAnimation;
  final Animation<Offset> floatingAnimation;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: fadeAnimation,
        child: SlideTransition(
          position: slideAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ScaleTransition(
                scale: scaleAnimation,
                child: SlideTransition(
                  position: floatingAnimation,
                  child: Container(
                    height: 160,
                    width: 160,
                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(40),
                      boxShadow: [
                        BoxShadow(
                          color: ColorName.primary.withValues(alpha: 0.2),
                          blurRadius: 30,
                          offset: const Offset(0, 15),
                          spreadRadius: -5,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(30),
                      child: Assets.image.icAppIconWithoutBackground.toAppIcon,
                    ),
                  ),
                ),
              ),

              VSizedBox.verticalBox48,

              const VText(
                StringConstants.appNameAllCaps,
                type: VTextStyleType.headlineLarge,
                fontWeight: FontWeight.w900,
              ),

              VSizedBox.verticalBox8,

              const VFaddedText(
                text: StringConstants.appSlogan,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
