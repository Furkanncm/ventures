import 'package:flutter/material.dart';
import 'package:ventures/common/router/router.dart';
import 'package:ventures/common/utils/enum/pref_keys.dart';
import 'package:ventures/common/utils/enum/route_path.dart';
import 'package:ventures/common/utils/extensions/string_extension.dart';
import 'package:ventures/domain/cache/cache_repository.dart';

class SplashView extends StatefulWidget {
  const SplashView({super.key});

  @override
  State<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends State<SplashView> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  Future<void> _checkLoginStatus() async {
    final isLoggedIn = CacheRepository.instance
        .getString(PrefKeys.isUserLoggedIn)
        .isNotNullOrNotEmpty;

    // 1 saniye bekletip yönlendirme yap (opsiyonel, splash efekti için)
    await Future<void>.delayed(const Duration(seconds: 1));

    if (isLoggedIn) {
      // Kullanıcı giriş yapmış → SpeechToText ekranına yönlendir
      router.goNamed(RoutePaths.Image.name);
    } else {
      // Kullanıcı giriş yapmamış → Login ekranına yönlendir
      router.goNamed(RoutePaths.login.name);
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
