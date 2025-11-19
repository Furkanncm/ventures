import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventures/common/app_init/app_init.dart';
import 'package:ventures/common/router/router.dart';
import 'package:ventures/common/theme/app_theme.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';

Future<void> main() async {
  await AppInit().initialize();
  runApp(const ProviderScope(child: VentureApp()));
}

class VentureApp extends StatelessWidget {
  const VentureApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: router,
      
      theme: AppLightTheme().themeData,
      title: StringConstants.appName,
    );
  }
}
