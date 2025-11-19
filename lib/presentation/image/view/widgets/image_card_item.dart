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
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      elevation: 6,
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.file(
              file,
              fit: BoxFit.cover,
            ),
          ),

          /// Sağ üst - İndir
          Positioned(
            top: 8,
            right: 8,
            child: IconButton(
              onPressed: onDownload,
              icon: const Icon(
                Icons.download,
                color: Colors.white,
                size: 26,
              ),
            ),
          ),

          /// Alt: paylaş (sol) - sil (sağ)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: VPadding.all() / 3,
              decoration: const CustomBoxDecoration.blackToTransparent(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  /// Sol alt - Paylaş
                  IconButton(
                    onPressed: onShare,
                    icon: const Icon(
                      Icons.share,
                      color: Colors.white,
                    ),
                  ),

                  /// Sağ alt - Sil
                  IconButton(
                    onPressed: onDelete,
                    icon: const Icon(
                      Icons.delete,
                      color: Colors.redAccent,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
