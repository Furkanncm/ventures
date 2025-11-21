part of '../image_history_view.dart';

@immutable
final class ImageGrid extends StatelessWidget {
  const ImageGrid({
    required this.images,
    required this.onRefresh,
    required this.onDelete,
    required this.onShare,
    required this.onDownload,
    super.key,
  });

  final List<File> images;
  final Future<void> Function() onRefresh;
  final void Function(File file) onDelete;
  final void Function(File file) onShare;
  final void Function(Uint8List url) onDownload;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: GridView.builder(
        padding: VPadding.all(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.55,
        ),
        itemCount: images.length,
        itemBuilder: (context, index) {
          final file = images[index];
          return ImageCardItem(
            file: file,
            onShare: () => onShare(file),
            onDelete: () => onDelete(file),
            onDownload: () => onDownload(file.readAsBytesSync()),
          );
        },
      ),
    );
  }
}
