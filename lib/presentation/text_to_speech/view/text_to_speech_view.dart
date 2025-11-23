import 'dart:io';

import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventures/common/bottom_sheet/v_bottom_sheets.dart';
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/common/router/router.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/route_path.dart';
import 'package:ventures/common/utils/enum/snackbar_type.dart';
import 'package:ventures/common/utils/padding/v_padding.dart';
import 'package:ventures/common/utils/snackbar/v_snackbar.dart';
import 'package:ventures/common/widgets/appbar/v_app_bar.dart';
import 'package:ventures/common/widgets/button/v_elevated_button.dart';
import 'package:ventures/common/widgets/card/input_card.dart';
import 'package:ventures/common/widgets/other/voice_icon.dart';
import 'package:ventures/common/widgets/sized_box/v_sized_box.dart';
import 'package:ventures/common/widgets/text/v_fadded_text.dart';
import 'package:ventures/common/widgets/text/v_text.dart';
import 'package:ventures/data/model/text_to_speech/audio_record.dart';
import 'package:ventures/presentation/text_to_speech/view/mixin/text_to_speech_mixin.dart';
import 'package:ventures/presentation/text_to_speech/view/widgets/play_share_button.dart';

part 'widgets/action_button.dart';
part 'widgets/input_section.dart';
part 'widgets/player_control.dart';
part 'widgets/voice_selector.dart';

@immutable
final class TTSPage extends ConsumerStatefulWidget {
  const TTSPage({super.key});

  @override
  ConsumerState<TTSPage> createState() => _TTSPageState();
}

class _TTSPageState extends ConsumerState<TTSPage> with TTSMixin {
  @override
  Widget build(BuildContext context) {
    final ttsState = ref.watch(ttsProvider);
    ref.listen(ttsProvider, (previous, next) {
      if (next.errorMessage != null &&
          next.errorMessage == StringConstants.freeLimitReached) {
        VSnackBar.show(
          context: context,
          text: StringConstants.freeLimitReached,
          type: SnackBarType.error,
        );
      }
    });

    return Scaffold(
      appBar: VAppbar(
        title: StringConstants.ttsTitle,
        actions: [
          IconButton(
            onPressed: () => router.goNamed(RoutePaths.audioHistory.name),
            icon: const Icon(Icons.history_outlined),
          ),
        ],
      ),
      body: Padding(
        padding: VPadding.pagePadding(),
        child: Column(
          spacing: 24,
          children: [
            _TTSInputSection(controller: textController),
            if (ttsState.isLoading)
              const Center(child: CircularProgressIndicator.adaptive())
            else
              const _VoiceSelector(),
            _TTSActionButton(
              onTap: onConvertPressed,
            ),

            if (ttsState.audioRecord != null && !ttsState.isLoading)
              _TTSPlayerControl(
                record: ttsState.audioRecord!,
                onPlay: () => playAudio(ttsState.audioRecord!.filePath),
                onShare: () => shareRecord(ttsState.audioRecord!.filePath),
              ),
          ],
        ),
      ),
    );
  }
}
