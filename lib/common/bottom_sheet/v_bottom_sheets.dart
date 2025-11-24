import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:stability_image_generation/stability_image_generation.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/extensions/context_extension.dart';
import 'package:ventures/common/utils/padding/v_padding.dart';
import 'package:ventures/common/widgets/other/voice_icon.dart';
import 'package:ventures/common/widgets/sized_box/v_sized_box.dart';
import 'package:ventures/common/widgets/text/v_fadded_text.dart';
import 'package:ventures/common/widgets/text/v_text.dart';
import 'package:ventures/data/model/voice/voice_model.dart';

part 'widgets/base_bottom_sheet.dart';
part 'widgets/document_bottom_sheet.dart';
part 'widgets/sheet_header.dart';
part 'widgets/sheet_option.dart';
part 'widgets/stlye_selection_sheet.dart';
part 'widgets/voice_selection_sheet.dart';

abstract class VBottomSheets {
  VBottomSheets._();

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
        child: _DocumentSourceBottomSheet(
          onCameraTap: onCameraTap,
          onGalleryTap: onGalleryTap,
          onPdfTap: onPdfTap,
        ),
      ),
    );
  }

  static Future<void> showVoiceSelectionSheet({
    required BuildContext context,
    required List<VoiceModel> voices,
    required VoiceModel? selectedVoice,
    required ValueChanged<VoiceModel> onVoiceSelected,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        maxHeight: context.screenHeight * 0.7,
      ),
      builder: (ctx) => VBaseBottomSheet(
        child: _VoiceSelectionSheet(
          voices: voices,
          selectedVoice: selectedVoice,
          onVoiceSelected: (voice) {
            Navigator.pop(ctx);
            onVoiceSelected(voice);
          },
        ),
      ),
    );
  }

  static Future<void> showStyleSelectionSheet({
    required BuildContext context,
    required ImageAIStyle selectedStyle,
    required ValueChanged<ImageAIStyle> onStyleSelected,
  }) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useRootNavigator: true,
      backgroundColor: Colors.transparent,
      constraints: BoxConstraints(
        maxHeight: MediaQuery.of(context).size.height * 0.7,
      ),
      builder: (ctx) => VBaseBottomSheet(
        child: _StyleSelectionSheet(
          selectedStyle: selectedStyle,
          onStyleSelected: (style) {
            Navigator.pop(ctx);
            onStyleSelected(style);
          },
        ),
      ),
    );
  }
}
