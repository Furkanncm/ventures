import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventures/common/providers/repository_providers.dart'; // appStartupProvider burada
import 'package:ventures/common/router/router.dart';
import 'package:ventures/common/utils/enum/route_path.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final _ = ref.watch(appStartupProvider);

    ref.listen(appStartupProvider, (previous, next) {
      next.when(
        data: (user) async {
          await Future<void>.delayed(const Duration(seconds: 1));

          if (user != null) {
            router.goNamed(RoutePaths.Image.name);
          } else {
            router.goNamed(RoutePaths.login.name);
          }
        },
        error: (err, stack) {
          router.goNamed(RoutePaths.login.name);
        },
        loading: () {
        },
      );
    });

    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
