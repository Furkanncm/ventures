import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/common/router/router.dart';
import 'package:ventures/common/utils/enum/route_path.dart';
import 'package:ventures/presentation/auth/splash/viewmodel/splash_notifier.dart';

class SplashView extends ConsumerWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    final _ = ref.watch(splashProvider);

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
