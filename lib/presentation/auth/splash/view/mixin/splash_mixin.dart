import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/common/router/router.dart';
import 'package:ventures/common/utils/enum/route_path.dart';
import 'package:ventures/presentation/auth/splash/view/splash_view.dart';
import 'package:ventures/presentation/auth/splash/viewmodel/splash_notifier.dart';

mixin SplashMixin on ConsumerState<SplashView> implements TickerProvider {
  late AnimationController entranceController;
  late AnimationController floatingController;

  late Animation<double> fadeAnimation;
  late Animation<Offset> slideAnimation;
  late Animation<double> scaleAnimation;
  late Animation<Offset> floatingAnimation;

  @override
  void initState() {
    super.initState();

    entranceController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(
        parent: entranceController,
        curve: const Interval(0, 0.6, curve: Curves.easeOut),
      ),
    );

    slideAnimation =
        Tween<Offset>(
          begin: const Offset(0, 0.2),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: entranceController,
            curve: const Interval(0, 0.6, curve: Curves.easeOutCubic),
          ),
        );

    scaleAnimation = Tween<double>(begin: 0.8, end: 1).animate(
      CurvedAnimation(
        parent: entranceController,
        curve: const Interval(0, 0.6, curve: Curves.easeOutBack),
      ),
    );

    floatingController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 3),
    )..repeat(reverse: true);

    floatingAnimation =
        Tween<Offset>(
          begin: const Offset(0, -0.02),
          end: const Offset(0, 0.02),
        ).animate(
          CurvedAnimation(
            parent: floatingController,
            curve: Curves.easeInOutSine,
          ),
        );

 
    entranceController.forward();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(splashProvider.notifier).init();
    });
  }

  @override
  void dispose() {
    entranceController.dispose();
    floatingController.dispose();
    super.dispose();
  }

  void useSplashListener() {
    ref.listen(splashProvider, (previous, next) {
      switch (next) {
        case SplashStatus.authenticated:
          router.goNamed(RoutePaths.Image.name);
        case SplashStatus.unauthenticated:
        case SplashStatus.error:
          router.goNamed(RoutePaths.login.name);
        case SplashStatus.loading:
          break;
      }
    });
  }

  @override
  Ticker createTicker(TickerCallback onTick) {
    return Ticker(onTick);
  }
}
