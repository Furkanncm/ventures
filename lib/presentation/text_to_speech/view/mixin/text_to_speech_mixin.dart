import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/snackbar_type.dart';
import 'package:ventures/common/utils/extensions/future_extension.dart';
import 'package:ventures/common/utils/snackbar/v_snackbar.dart';
import 'package:ventures/domain/share/share_repository.dart';

mixin TTSMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  late final TextEditingController textController;
  late final AudioPlayer audioPlayer;

  @override
  void initState() {
    super.initState();
    textController = TextEditingController();
    audioPlayer = AudioPlayer();
  }

  Future<void> disposeMixin() async {
    textController.dispose();
    await audioPlayer.dispose();
  }

  Future<void> playAudio(String filePath) async {
    await audioPlayer.play(DeviceFileSource(filePath));
  }

  Future<void> shareRecord(String filePath) async {
    final result = await ShareRepository.instance
        .shareAudio(filePath)
        .withLoading(context);
    if (!mounted) return;

    switch (result) {
      case ShareResultStatus.success:
        VSnackBar.show(
          context: context,
          text: StringConstants.shareAudioSuccess,
          type: SnackBarType.info,
        );
      case ShareResultStatus.dismissed:
      case ShareResultStatus.unavailable:
        VSnackBar.show(
          context: context,
          text: StringConstants.shareAudioFail,
          type: SnackBarType.error,
        );
    }
  }

  Future<void> onConvertPressed() async {
    if (textController.text.isNotEmpty) {
      FocusScope.of(context).unfocus();
      final ttsNotifier = ref.read(ttsProvider.notifier);
      await ttsNotifier
          .convertTextToSpeech(text: textController.text)
          .withLoading(context);
    }
  }

  @override
  void dispose() {
    super.dispose();
    unawaited(disposeMixin());
  }
}
