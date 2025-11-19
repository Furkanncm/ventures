import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/common/router/router.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/route_path.dart';
import 'package:ventures/common/utils/padding/lg_padding.dart';
import 'package:ventures/common/widgets/button/v_elevated_button.dart';
import 'package:ventures/common/widgets/sized_box/v_sized_box.dart';
import 'package:ventures/common/widgets/text/v_text.dart';
import 'package:ventures/common/widgets/textfied/v_textfield.dart';
import 'package:ventures/presentation/image/view/mixin/image_view_mixin.dart';
import 'package:ventures/presentation/image/viewmodel/image_generation_state.dart';

part 'widgets/app_bar.dart';
part 'widgets/body.dart';
part 'widgets/image_field.dart';
part 'widgets/input_card.dart';

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
      appBar: const _AppBar(),
      body: _Body(
        state: state,
        onPressed: generateImage,
        controller: controller,
      ),
    );
  }
}
