part of '../text_to_speech_view.dart';

@immutable
final class _TTSPlayerControl extends StatelessWidget {
  const _TTSPlayerControl({
    required this.record,
    required this.onPlay,
    required this.onShare,
  });

  final AudioRecord record;
  final VoidCallback onPlay;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 12,
      children: [
        const Divider(),
        const VText(
          StringConstants.play,
          color: ColorName.onSuccess,
          fontWeight: FontWeight.bold,
        ),
        PlayAndShareButton(onPlay: onPlay, onShare: onShare),
        FutureBuilder<int>(
          future: File(record.filePath).length(),
          builder: (context, snapshot) {
            final sizeKB = (snapshot.data ?? 0) / 1024;
            return VFaddedText(
              text:
                  '${StringConstants.fileSize}: ${sizeKB.toStringAsFixed(2)} KB',
              textStyleType: VTextStyleType.bodySmall,
            );
          },
        ),
      ],
    );
  }
}
