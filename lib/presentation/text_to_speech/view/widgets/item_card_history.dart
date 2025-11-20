part of '../text_to_speech_history_view.dart';

@immutable
final class _HistoryItemCard extends StatelessWidget {
  const _HistoryItemCard({
    required this.record,
    required this.isPlaying,
    required this.onPlayTap,
    required this.onDeleteTap,
    required this.onShareTap,
  });

  final AudioRecord record;
  final bool isPlaying;
  final VoidCallback onPlayTap;
  final VoidCallback onDeleteTap;
  final VoidCallback onShareTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const VPadding.cardPadding(),
        leading: CircleAvatar(
          backgroundColor: isPlaying ? ColorName.onSuccess : ColorName.primary,
          child: IconButton(
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(),
            icon: Icon(isPlaying ? Icons.stop : Icons.play_arrow),
            color: Colors.white,
            onPressed: onPlayTap,
          ),
        ),

        title: VText(
          type: VTextStyleType.bodyLarge,
          record.text,
          maxLines: 3,
          fontWeight: FontWeight.w600,
        ),
        subtitle: VFaddedText(
          textStyleType: VTextStyleType.bodySmall,
          text: DateFormat(StringConstants.dateFormat).format(record.createdAt),
        ),

        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.share, color: ColorName.gray),
              onPressed: onShareTap,
            ),
            IconButton(
              icon: const Icon(Icons.delete_outline, color: ColorName.gray),
              onPressed: onDeleteTap,
            ),
          ],
        ),
      ),
    );
  }
}
