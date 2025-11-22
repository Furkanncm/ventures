import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/padding/v_padding.dart';
import 'package:ventures/common/widgets/sized_box/v_sized_box.dart';
import 'package:ventures/common/widgets/text/v_fadded_text.dart';
import 'package:ventures/common/widgets/text/v_text.dart';

part 'widgets/base_bottom_sheet.dart';
part 'widgets/sheet_header.dart';
part 'widgets/sheet_option.dart';

abstract class VBottomSheets {
  VBottomSheets._();

  /// Resim veya Dosya Kaynağı Seçimi İçin Bottom Sheet
  static Future<void> showImageSourceSheet({
    required BuildContext context,
    required VoidCallback onCameraTap,
    required VoidCallback onGalleryTap,
    VoidCallback? onPdfTap,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      useRootNavigator: true,
      builder: (ctx) => VBaseBottomSheet(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // StringConstants kullanımı
            const _SheetHeader(title: StringConstants.selectSource),

            // 1. Kamera
            _SheetOption(
              icon: Icons.camera_alt_rounded,
              title: StringConstants.takePhoto,
              onTap: () {
                Navigator.pop(ctx);
                onCameraTap();
              },
            ),

            // 2. Galeri
            _SheetOption(
              icon: Icons.photo_library_rounded,
              title: StringConstants.chooseFromGallery,
              onTap: () {
                Navigator.pop(ctx);
                onGalleryTap();
              },
            ),

            // 3. PDF (Opsiyonel)
            if (onPdfTap != null)
              _SheetOption(
                icon: Icons.picture_as_pdf_rounded,
                title: StringConstants.choosePdf,
                onTap: () {
                  Navigator.pop(ctx);
                  onPdfTap();
                },
              ),
          ],
        ),
      ),
    );
  }
}
