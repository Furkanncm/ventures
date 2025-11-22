import 'dart:async';

import 'package:audioplayers/audioplayers.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ventures/common/dialog/v_dialog.dart';
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/snackbar_type.dart';
import 'package:ventures/common/utils/extensions/future_extension.dart';
import 'package:ventures/common/utils/snackbar/v_snackbar.dart';
import 'package:ventures/data/model/text_to_speech/audio_record.dart';
import 'package:ventures/domain/download/download_repository.dart';
import 'package:ventures/domain/share/share_repository.dart';

mixin AudioHistoryMixin<T extends ConsumerStatefulWidget> on ConsumerState<T> {
  final AudioPlayer audioPlayer = AudioPlayer();

  String? playingRecordId;

  @override
  void dispose() {
    audioPlayer.dispose();
    super.dispose();
  }

  Future<void> togglePlay(AudioRecord record) async {
    if (playingRecordId == record.id) {
      await audioPlayer.stop();
      setState(() => playingRecordId = null);
    } else {
      await audioPlayer.stop();

      await audioPlayer.play(DeviceFileSource(record.filePath));

      setState(() => playingRecordId = record.id);

      audioPlayer.onPlayerComplete.listen((_) {
        if (mounted) {
          setState(() => playingRecordId = null);
        }
      });
    }
  }

  Future<void> shareRecord(AudioRecord record) async {
    final result = await ShareRepository.instance
        .shareAudio(record.filePath)
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

  Future<void> deleteRecord(AudioRecord record) async {
    await VDialogs.confirmationDialog(
      context: context,
      onPositiveButton: () async {
        final repository = ref.read(historyRepositoryProvider);
        await repository.deleteRecord(record);
        final _ = ref.refresh(historyListProvider);
      },
      title: StringConstants.deleteDialogTitle,
      content: StringConstants.deleteDialogContent,
    );
  }

  Future<void> downloadRecord(AudioRecord record) async {
    final fileName = 'Audio_${record.createdAt.millisecondsSinceEpoch}';

    final result = await DownloadRepository.instance.saveAudioToDevice(
      filePath: record.filePath,
      fileName: fileName,
    );

    if (!mounted) return;
    if (result) {
      VSnackBar.show(
        context: context,
        text: StringConstants.saveAudioSuccess,
        type: SnackBarType.info,
      );
    } else {
      VSnackBar.show(
        context: context,
        text: StringConstants.saveAudioFail,
        type: SnackBarType.error,
      );
    }
  }
}
