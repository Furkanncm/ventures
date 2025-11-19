import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/extensions/future_extension.dart';
import 'package:ventures/presentation/image/view/image_view.dart';

mixin ImageViewMixin on ConsumerState<ImageView> {
  final controller = TextEditingController();

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
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
}
