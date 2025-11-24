import 'package:codegen/gen/assets.gen.dart';
import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/extensions/assets_extension.dart';
import 'package:ventures/common/widgets/sized_box/v_sized_box.dart';
import 'package:ventures/common/widgets/text/v_fadded_text.dart';
import 'package:ventures/common/widgets/text/v_text.dart';
import 'package:ventures/presentation/auth/splash/view/mixin/splash_mixin.dart';

part 'widgets/splash_content.dart';
part 'widgets/splash_loading.dart';

@immutable
final class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with TickerProviderStateMixin, SplashMixin {
  @override
  Widget build(BuildContext context) {
    useSplashListener();

    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          _SplashContent(
            fadeAnimation: fadeAnimation,
            slideAnimation: slideAnimation,
            scaleAnimation: scaleAnimation,
            floatingAnimation: floatingAnimation,
          ),

          Positioned(
            bottom: 60,
            left: 0,
            right: 0,
            child: _SplashLoading(fadeAnimation: fadeAnimation),
          ),
        ],
      ),
    );
  }
}
