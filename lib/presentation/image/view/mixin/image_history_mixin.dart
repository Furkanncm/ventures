import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ventures/common/dialog/v_dialog.dart';
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/snackbar_type.dart';
import 'package:ventures/common/utils/extensions/future_extension.dart';
import 'package:ventures/common/utils/snackbar/v_snackbar.dart';
import 'package:ventures/domain/share/share_repository.dart';
import 'package:ventures/presentation/image/view/image_history_view.dart';

mixin ImageHistoryMixin on ConsumerState<ImageHistoryView> {
  late final ShareRepository _shareRepository;
  @override
  void initState() {
    super.initState();
    _shareRepository = ShareRepository.instance;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final _ = ref.refresh(imageHistoryProvider);
    });
  }

  Future<void> onDeletePressed(File file) async {
    await VDialogs.confirmationDialog(
      context: context,
      title: StringConstants.sure,
      content: StringConstants.deleteContent,
      onPositiveButton: () async {
        final repo = ref.read(
          imageRepoProvider,
        );

        await repo.deleteImage(
          file.path.split('/').last,
        );
        final _ = ref.refresh(imageHistoryProvider);
      },
    );
  }

  Future<void> onSharePressed(File imageFile) async {
    final result = await _shareRepository
        .shareImage(imageFile.path)
        .withLoading(context);
    if (!mounted) return;

    switch (result) {
      case ShareResultStatus.success:
        VSnackBar.show(
          context: context,
          text: StringConstants.shareImageSuccess,
          type: SnackBarType.info,
        );
      case ShareResultStatus.dismissed:
      case ShareResultStatus.unavailable:
        VSnackBar.show(
          context: context,
          text: StringConstants.shareImageFail,
          type: SnackBarType.error,
        );
    }
  }

  Future<void> onDownloadPressed(Uint8List url) async {
    final repo = ref.read(imageRepoProvider);

    final result = await repo
        .saveImageToGallery(
          url,
          'image_${DateTime.now().millisecondsSinceEpoch}.png',
        )
        .withLoading(context);

    if (!mounted) return;

    if (result) {
      VSnackBar.show(
        context: context,
        text: StringConstants.shareImageSuccess,
        type: SnackBarType.info,
      );
    } else {
      VSnackBar.show(
        context: context,
        text: StringConstants.shareImageFail,
        type: SnackBarType.error,
      );
    }
  }
}
