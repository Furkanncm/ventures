part of '../v_bottom_sheets.dart';

@immutable
final class _DocumentSourceBottomSheet extends StatelessWidget {
  const _DocumentSourceBottomSheet({
    required this.onCameraTap,
    required this.onGalleryTap,
    this.onPdfTap,
  });

  final VoidCallback onCameraTap;
  final VoidCallback onGalleryTap;
  final VoidCallback? onPdfTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const _SheetHeader(title: StringConstants.selectSource),

        _SheetOption(
          icon: Icons.camera_alt_rounded,
          title: StringConstants.takePhoto,
          onTap: () {
            Navigator.pop(context); 
            onCameraTap();
          },
        ),

        _SheetOption(
          icon: Icons.photo_library_rounded,
          title: StringConstants.chooseFromGallery,
          onTap: () {
            Navigator.pop(context); 
            onGalleryTap();
          },
        ),

        if (onPdfTap != null)
          _SheetOption(
            icon: Icons.picture_as_pdf_rounded,
            title: StringConstants.choosePdf,
            onTap: () {
              Navigator.pop(context); 
              onPdfTap!(); 
            },
          ),
      ],
    );
  }
}