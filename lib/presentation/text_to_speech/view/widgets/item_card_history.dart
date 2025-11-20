part of '../text_to_speech_history_view.dart';

@immutable
final class _HistoryItemCard extends StatelessWidget {
  const _HistoryItemCard({
    required this.record,
    required this.isPlaying,
    required this.onPlayTap,
    required this.onDeleteTap,
    required this.onShareTap,
    required this.onDownloadTap,
  });

  final AudioRecord record;
  final bool isPlaying;
  final VoidCallback onPlayTap;
  final VoidCallback onDeleteTap;
  final VoidCallback onShareTap;
  final VoidCallback onDownloadTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.primaryColor;
    final activeColor = isPlaying ? ColorName.onSuccess : primaryColor;

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Padding(
        padding: VPadding.all(),
        child: Column(
          children: [
            _DetailAndDeleteButton(
              isPlaying: isPlaying,
              onPlayTap: onPlayTap,
              activeColor: activeColor,
              record: record,
              theme: theme,
              onDeleteTap: onDeleteTap,
            ),
            VSizedBox.verticalBox16,
            Divider(height: 1, color: theme.dividerColor.withValues(alpha: .5)),
            VSizedBox.verticalBox12,
            _DownloadAndShareButtons(
              onDownloadTap: onDownloadTap,
              onShareTap: onShareTap,
            ),
          ],
        ),
      ),
    );
  }
}

@immutable
final class _DetailAndDeleteButton extends StatelessWidget {
  const _DetailAndDeleteButton({
    required this.isPlaying,
    required this.onPlayTap,
    required this.activeColor,
    required this.record,
    required this.theme,
    required this.onDeleteTap,
  });

  final bool isPlaying;
  final VoidCallback onPlayTap;
  final Color activeColor;
  final AudioRecord record;
  final ThemeData theme;
  final VoidCallback onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _PlayButton(
          isPlaying: isPlaying,
          onTap: onPlayTap,
          activeColor: activeColor,
        ),
        VSizedBox.horizontalBox16,
        _TitleAndDate(record: record, theme: theme),
        IconButton(
          icon: const Icon(
            Icons.delete_outline_rounded,
            color: ColorName.onError,
          ),
          onPressed: onDeleteTap,
          padding: VPadding.all() / 3,
        ),
      ],
    );
  }
}

@immutable
final class _DownloadAndShareButtons extends StatelessWidget {
  const _DownloadAndShareButtons({
    required this.onDownloadTap,
    required this.onShareTap,
  });

  final VoidCallback onDownloadTap;
  final VoidCallback onShareTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _TonalActionButton(
          icon: Icons.download_rounded,
          color: ColorName.onSuccess,
          onTap: onDownloadTap,
        ),
        VSizedBox.horizontalBox12,
        _TonalActionButton(
          icon: Icons.share_rounded,
          color: ColorName.gray,
          onTap: onShareTap,
        ),
      ],
    );
  }
}

@immutable
final class _TitleAndDate extends StatelessWidget {
  const _TitleAndDate({
    required this.record,
    required this.theme,
  });

  final AudioRecord record;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          VText(
            type: VTextStyleType.bodyLarge,
            record.text,
            maxLines: 3,
            fontWeight: FontWeight.w600,
          ),
          VSizedBox.verticalBox8,
          Row(
            children: [
              Icon(
                Icons.access_time_rounded,
                size: 14,
                color: theme.hintColor,
              ),
              VSizedBox.horizontalBox4,
              VFaddedText(
                textStyleType: VTextStyleType.bodySmall,
                text: DateFormat(
                  StringConstants.dateFormat,
                ).format(record.createdAt),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

@immutable
final class _PlayButton extends StatelessWidget {
  const _PlayButton({
    required this.isPlaying,
    required this.onTap,
    required this.activeColor,
  });

  final bool isPlaying;
  final VoidCallback onTap;
  final Color activeColor;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        customBorder: const CircleBorder(),
        splashColor: activeColor.withValues(alpha: 0.3),
        child: Container(
          width: 52,
          height: 52,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: activeColor,
            boxShadow: [
              BoxShadow(
                color: activeColor.withValues(alpha: 0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Icon(
            isPlaying ? Icons.stop_rounded : Icons.play_arrow_rounded,
            color: ColorName.backgroundLight,
            size: 30,
          ),
        ),
      ),
    );
  }
}

@immutable
final class _TonalActionButton extends StatelessWidget {
  const _TonalActionButton({
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final backgroundColor = color.withValues(alpha: 0.08);
    return Expanded(
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12),
          splashColor: color.withValues(alpha: 0.2),
          highlightColor: color.withValues(alpha: 0.1),
          child: Container(
            padding: VPadding.verticalMediumPadding() * 0.75,
            alignment: Alignment.center,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  color: color.withValues(alpha: 0.9),
                  size: 22,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
