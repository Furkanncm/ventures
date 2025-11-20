import 'dart:typed_data';

import 'package:audioplayers/audioplayers.dart';
import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/common/router/router.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/decoration/box_decoration.dart';
import 'package:ventures/common/utils/enum/route_path.dart';
import 'package:ventures/common/utils/extensions/future_extension.dart';
import 'package:ventures/common/utils/padding/v_padding.dart';
import 'package:ventures/common/widgets/button/v_elevated_button.dart';
import 'package:ventures/common/widgets/card/input_card.dart';
import 'package:ventures/common/widgets/sized_box/v_sized_box.dart';
import 'package:ventures/common/widgets/text/v_fadded_text.dart';
import 'package:ventures/common/widgets/text/v_text.dart';
import 'package:ventures/data/model/text_to_speech/audio_record.dart';
import 'package:ventures/domain/share/share_repository.dart';

class TTSPage extends ConsumerStatefulWidget {
  const TTSPage({super.key});

  @override
  ConsumerState<TTSPage> createState() => _TTSPageState();
}

class _TTSPageState extends ConsumerState<TTSPage> {
  final TextEditingController _controller = TextEditingController();
  final AudioPlayer _audioPlayer = AudioPlayer();

  @override
  void dispose() {
    _controller.dispose();
    _audioPlayer.dispose();
    super.dispose();
  }

  Future<void> _playAudio(List<int> bytes) async {
    await _audioPlayer.play(BytesSource(Uint8List.fromList(bytes)));
  }

    Future<void> _shareRecord(AudioRecord record) async {
    await ShareRepository.instance.shareAudio(record.filePath);
  }

  @override
  Widget build(BuildContext context) {
    final ttsState = ref.watch(ttsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const VText(
          'Text To Speech',
          type: VTextStyleType.titleLarge,
        ),
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
            _TTSInputSection(controller: _controller),
            _TTSActionButton(controller: _controller),
            if (ttsState.errorMessage != null)
              _TTSErrorDisplay(errorMessage: ttsState.errorMessage!),
            if (ttsState.audioBytes != null && !ttsState.isLoading)
              _TTSPlayerControl(
                audioBytes: ttsState.audioBytes!,
                onPlay: _playAudio,
              ),
          ],
        ),
      ),
    );
  }
}

class _TTSInputSection extends StatelessWidget {
  const _TTSInputSection({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return InputCard(
      controller: controller,
      maxLines: 6,
    );
  }
}

class _TTSActionButton extends ConsumerWidget {
  const _TTSActionButton({required this.controller});

  final TextEditingController controller;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return VElevatedButton.withIconAndFullWith(
      onPressed: () async {
        if (controller.text.isNotEmpty) {
          FocusScope.of(context).unfocus();

          // Notifier'a erişim
          final ttsNotifier = ref.read(ttsProvider.notifier);

          await ttsNotifier
              .convertTextToSpeech(text: controller.text)
              .withLoading(context);
        }
      },
      icon: const Icon(Icons.record_voice_over),
      label: 'Sese Çevir',
    );
  }
}

class _TTSErrorDisplay extends StatelessWidget {
  const _TTSErrorDisplay({required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: VPadding.all() / 2,
      decoration: CustomBoxDecoration.errorContainer(),
      child: VText(
        '${StringConstants.errorUnknown}: $errorMessage',
        color: ColorName.onError,
      ),
    );
  }
}

class _TTSPlayerControl extends StatelessWidget {
  const _TTSPlayerControl({
    required this.audioBytes,
    required this.onPlay,
  });

  final List<int> audioBytes;

  final void Function(List<int>) onPlay;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Divider(),
        VSizedBox.verticalBox12,
        const VText(
          'Ses Hazır!',
          color: ColorName.onSuccess,
          fontWeight: FontWeight.bold,
        ),
        VSizedBox.verticalBox12,
        VElevatedButton(
          backgroundColor: ColorName.onSuccess,
          onPressed: () => onPlay(audioBytes),
          icon: const Icon(Icons.play_arrow),
          label: 'Sesi Oynat',
        ),
        VSizedBox.verticalBox8,
        LgFaddedText(
          text: 'Boyut: ${(audioBytes.length / 1024).toStringAsFixed(2)} KB',
          textStyleType: VTextStyleType.bodySmall,
        ),
      ],
    );
  }
}
