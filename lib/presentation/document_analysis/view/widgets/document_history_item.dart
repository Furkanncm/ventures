part of '../document_analysis_history_view.dart';

@immutable
final class _DocumentHistoryItem extends StatelessWidget {
  const _DocumentHistoryItem({
    required this.record,
    required this.onTap,
    required this.onDelete,
    required this.onShare,
    required this.onDownload,
  });

  final DocumentAnalysisRecord record;
  final VoidCallback onTap;
  final VoidCallback onDelete;
  final VoidCallback onShare;
  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Padding(
          padding: VPadding.all(),
          child: Column(
            children: [
              _TopSection(record: record, onDeleteTap: onDelete),
              VSizedBox.verticalBox16,
              const Divider(height: 1),
              VSizedBox.verticalBox12,
              _ActionButtons(
                onDownloadTap: onDownload,
                onShareTap: onShare,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

@immutable
final class _TopSection extends StatelessWidget {
  const _TopSection({
    required this.record,
    required this.onDeleteTap,
  });

  final DocumentAnalysisRecord record;
  final VoidCallback onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _FilePreviewBox(record: record),

        VSizedBox.horizontalBox16,

        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VText(
                record.fileName ?? StringConstants.untitledDocument,
                type: VTextStyleType.bodyLarge,
                maxLines: 2,
                fontWeight: FontWeight.w600,
              ),
              VSizedBox.verticalBox8,
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today_rounded,
                    size: 14,
                    color: ColorName.gray,
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
        ),
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
class _FilePreviewBox extends StatelessWidget {
  const _FilePreviewBox({required this.record});

  final DocumentAnalysisRecord record;

  @override
  Widget build(BuildContext context) {
    final isPdf = record.imagePath?.endsWith('.pdf') ?? false;
    final hasImage =
        record.imagePath != null && File(record.imagePath!).existsSync();

    return Container(
      width: 52,
      height: 52,
      decoration: BoxDecoration(
        color: isPdf
            ? ColorName.onError.withValues(alpha: 0.1)
            : ColorName.primary.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(
          16,
        ),
        border: Border.all(
          color: isPdf
              ? ColorName.onError.withValues(alpha: 0.3)
              : ColorName.primary.withValues(alpha: 0.3),
        ),
        image: (hasImage && !isPdf)
            ? DecorationImage(
                image: FileImage(File(record.imagePath!)),
                fit: BoxFit.cover,
              )
            : null,
      ),
      child: isPdf
          ? const Icon(
              Icons.picture_as_pdf_rounded,
              color: ColorName.onError,
              size: 28,
            )
          : (!hasImage
                ? Icon(
                    Icons.description_rounded,
                    color: Theme.of(context).primaryColor,
                    size: 28,
                  )
                : null),
    );
  }
}

@immutable
class _ActionButtons extends StatelessWidget {
  const _ActionButtons({
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
          label: StringConstants.download,
        ),
        VSizedBox.horizontalBox12,
        _TonalActionButton(
          icon: Icons.share_rounded,
          color: ColorName.gray,
          onTap: onShareTap,
          label: StringConstants.share,
        ),
      ],
    );
  }
}

@immutable
class _TonalActionButton extends StatelessWidget {
  const _TonalActionButton({
    required this.icon,
    required this.color,
    required this.onTap,
    this.label,
  });

  final IconData icon;
  final Color color;
  final VoidCallback onTap;
  final String? label;

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
                if (label != null) ...[
                  VSizedBox.horizontalBox8,
                  VText(
                    label!,
                    color: color.withValues(alpha: 0.9),
                    fontWeight: FontWeight.w600,
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}
