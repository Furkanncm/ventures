import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ventures/common/utils/enum/route_path.dart';
import 'package:ventures/common/widgets/bottom_navigation_bar/v_bottom_navigation_bar.dart';
import 'package:ventures/presentation/auth/login/view/login_view.dart';
import 'package:ventures/presentation/auth/sign_up/view/sign_up_view.dart';
import 'package:ventures/presentation/auth/splash/view/splash_view.dart';
import 'package:ventures/presentation/image/view/image_history_view.dart';
import 'package:ventures/presentation/image/view/image_view.dart';
import 'package:ventures/presentation/profile/view/profile_view.dart';
import 'package:ventures/presentation/text_to_speech/view/text_to_speech_history_view.dart';
import 'package:ventures/presentation/text_to_speech/view/text_to_speech_view.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();
final GoRouter router = GoRouter(
  navigatorKey: _rootNavigatorKey,
  initialLocation: RoutePaths.splash.path,
  routes: [
    GoRoute(
      name: RoutePaths.splash.name,
      path: RoutePaths.splash.path,
      builder: (context, state) => const SplashView(),
    ),
    GoRoute(
      name: RoutePaths.login.name,
      path: RoutePaths.login.path,
      builder: (context, state) => const LoginView(),
    ),
    GoRoute(
      name: RoutePaths.signUp.name,
      path: RoutePaths.signUp.path,
      builder: (context, state) => const SignUpView(),
    ),

    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) => AppNavigationBar(child: child),
      routes: [
        GoRoute(
          path: RoutePaths.Audio.path,
          name: RoutePaths.Audio.name,
          pageBuilder: (context, state) => const NoTransitionPage(
            child: TTSPage(),
          ), routes: [
            GoRoute(
              path: RoutePaths.audioHistory.path,
              name: RoutePaths.audioHistory.name,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: AudioHistoryView()),
            ),
          ],
        ),
        GoRoute(
          path: RoutePaths.Image.path,
          name: RoutePaths.Image.name,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ImageView()),
          routes: [
            GoRoute(
              path: RoutePaths.imageHistory.path,
              name: RoutePaths.imageHistory.name,
              pageBuilder: (context, state) =>
                  const NoTransitionPage(child: ImageHistoryView()),
            ),
          ],
        ),
        GoRoute(
          path: RoutePaths.Document.path,
          name: RoutePaths.Document.name,
          pageBuilder: (context, state) => NoTransitionPage(
            child: Container(
              color: ColorName.secondary,
            ),
          ),
        ),
        GoRoute(
          path: RoutePaths.Profile.path,
          name: RoutePaths.Profile.name,
          pageBuilder: (context, state) =>
              const NoTransitionPage(child: ProfileView()),
        ),
      ],
    ),
  ],
);
