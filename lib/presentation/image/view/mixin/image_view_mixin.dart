import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/common/router/router.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/route_path.dart';
import 'package:ventures/common/utils/enum/snackbar_type.dart';
import 'package:ventures/common/utils/extensions/future_extension.dart';
import 'package:ventures/common/utils/snackbar/v_snackbar.dart';
import 'package:ventures/domain/share/share_repository.dart';
import 'package:ventures/presentation/image/view/image_view.dart';
import 'package:ventures/presentation/image/viewmodel/image_generation_state.dart';

mixin ImageViewMixin on ConsumerState<ImageView> {
  late final TextEditingController controller;
  late final ImageGenerationState state;
  late final ShareRepository _shareRepository;
  @override
  void initState() {
    super.initState();
    _shareRepository = ShareRepository.instance;
    controller = TextEditingController();
    state = ref.read(imageGenerationProvider);
  }

  Future<void> generateImage() async {
    final prompt = controller.text.trim();
    if (prompt.isNotEmpty) {
      await ref
          .read(imageGenerationProvider.notifier)
          .generate(prompt)
          .withLoading(context)
          .withSnackbar(
            context,
            successMessage: StringConstants.imageSuccessMessage,
          );
    }
  }

  void onRouteHistory() {
    router.goNamed(RoutePaths.imageHistory.name);
  }

  Future<void> onSharePressed() async {
    final imageFile = ref.read(imageGenerationProvider).imageFile;
    if (imageFile == null) return;
    final result = await _shareRepository
        .shareImage(imageFile.path)
        .withLoading(context);
    if (!mounted) return;

    switch (result) {
      case ShareResultStatus.success:
        VSnackBar.show(
          context: context,
          text: StringConstants.shareSuccess,
          type: SnackBarType.info,
        );
      case ShareResultStatus.dismissed:
      case ShareResultStatus.unavailable:
        VSnackBar.show(
          context: context,
          text: StringConstants.shareFail,
          type: SnackBarType.error,
        );
    }
  }

  @override
  void dispose() {
    controller.dispose();
    state.copyWith();
    super.dispose();
  }
}
