part of '../image_history_view.dart';

@immutable
final class ImageCardItem extends StatelessWidget {
  const ImageCardItem({
    required this.file,
    required this.onShare,
    required this.onDelete,
    required this.onDownload,
    super.key,
  });

  final File file;
  final VoidCallback onShare;
  final VoidCallback onDelete;
  final VoidCallback onDownload;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 2, // Biraz daha belirgin olması için artırılabilir
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      clipBehavior: Clip.antiAlias,
      child: Padding(
        padding: VPadding.all(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Resim alanı esnek bırakıldı, kalan alanı dolduracak
            Expanded(
              child: _ImageDisplay(file: file),
            ),

            VSizedBox.verticalBox12,
            Divider(height: 1, color: theme.dividerColor.withValues(alpha: .5)),
            VSizedBox.verticalBox12,

            // Butonlar
            _ActionButtons(
              onDownloadTap: onDownload,
              onShareTap: onShare,
              onDeleteTap: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}

@immutable
final class _ImageDisplay extends StatelessWidget {
  const _ImageDisplay({required this.file});

  final File file;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => VDialogs.photoDialog(context: context, file: file),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          border: Border.all(
            color: Theme.of(context).dividerColor.withValues(alpha: 0.2),
          ),
          image: DecorationImage(
            image: FileImage(file),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}

@immutable
final class _ActionButtons extends StatelessWidget {
  const _ActionButtons({
    required this.onDownloadTap,
    required this.onShareTap,
    required this.onDeleteTap,
  });

  final VoidCallback onDownloadTap;
  final VoidCallback onShareTap;
  final VoidCallback onDeleteTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 54,
      child: Row(
        children: [
          _TonalActionButton(
            icon: Icons.download_rounded,
            color: ColorName.onSuccess,
            onTap: onDownloadTap,
          ),
          VSizedBox.horizontalBox8,
          _TonalActionButton(
            icon: Icons.share_rounded,
            color: ColorName.gray,
            onTap: onShareTap,
          ),
          VSizedBox.horizontalBox8,
          _TonalActionButton(
            icon: Icons.delete_outline_rounded,
            color: ColorName.onError,
            onTap: onDeleteTap,
          ),
        ],
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
    final backgroundColor = color.withValues(alpha: 0.1);
    return Expanded(
      child: Material(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(14),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(14),
          splashColor: color.withValues(alpha: 0.2),
          highlightColor: color.withValues(alpha: 0.1),
          child: Center(
            child: Icon(
              icon,
              color: color.withValues(alpha: 1),
              size: 26,
            ),
          ),
        ),
      ),
    );
  }
}
