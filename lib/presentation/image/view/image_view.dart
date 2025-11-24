import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/feature_type.dart';
import 'package:ventures/common/utils/padding/v_padding.dart';
import 'package:ventures/common/widgets/appbar/v_app_bar.dart';
import 'package:ventures/common/widgets/button/v_elevated_button.dart';
import 'package:ventures/common/widgets/card/input_card.dart';
import 'package:ventures/common/widgets/other/no_history_found.dart';
import 'package:ventures/presentation/image/view/mixin/image_view_mixin.dart';
import 'package:ventures/presentation/image/viewmodel/image_generation_state.dart';

part 'widgets/app_bar.dart';
part 'widgets/body.dart';
part 'widgets/image_field.dart';

@immutable
final class ImageView extends ConsumerStatefulWidget {
  const ImageView({super.key});

  @override
  ConsumerState<ImageView> createState() => _ImageViewState();
}

class _ImageViewState extends ConsumerState<ImageView> with ImageViewMixin {
  @override
  Widget build(BuildContext context) {
    final state = ref.watch(imageGenerationProvider);

    return Scaffold(
      appBar: _AppBar(onRouteHistory: onRouteHistory),
      body: _Body(
        state: state,
        onPressed: generateImage,
        onSharePressed: onSharePressed,
        controller: controller,
      ),
    );
  }
}
