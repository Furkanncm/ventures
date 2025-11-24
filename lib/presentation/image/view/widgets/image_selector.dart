import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stability_image_generation/stability_image_generation.dart';
import 'package:ventures/common/bottom_sheet/v_bottom_sheets.dart';
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/padding/v_padding.dart';
import 'package:ventures/common/widgets/sized_box/v_sized_box.dart';
import 'package:ventures/common/widgets/text/v_fadded_text.dart';
import 'package:ventures/common/widgets/text/v_text.dart';

@immutable
final class StyleSelector extends ConsumerWidget {
  const StyleSelector({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(imageGenerationProvider);
    final notifier = ref.read(imageGenerationProvider.notifier);

    final selectedStyle = state.selectedStyle;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const VFaddedText(
          text: StringConstants.imageSelectStyle,
          textStyleType: VTextStyleType.titleSmall,
        ),
        VSizedBox.verticalBox8,

        InkWell(
          onTap: () async {
            await VBottomSheets.showStyleSelectionSheet(
              context: context,
              selectedStyle: selectedStyle,
              onStyleSelected: notifier.selectStyle,
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: VPadding.all(),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: ColorName.gray.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              children: [
                _StyleIcon(style: selectedStyle),

                VSizedBox.horizontalBox12,

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VText(
                        _formatStyleName(selectedStyle),
                        fontWeight: FontWeight.bold,
                      ),
                      if (selectedStyle != ImageAIStyle.noStyle) ...[
                        VSizedBox.verticalBox4,
                        const VText(
                          StringConstants.aiSelectyStyle,
                          type: VTextStyleType.bodySmall,
                          color: ColorName.gray,
                        ),
                      ],
                    ],
                  ),
                ),

                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: ColorName.gray,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  String _formatStyleName(ImageAIStyle style) {
    if (style == ImageAIStyle.noStyle) return StringConstants.noStyleImage;

    final name = style.name;
    return name.replaceAllMapped(RegExp('([a-z])([A-Z])'), (Match m) {
      return '${m[1]} ${m[2]}';
    }).toUpperCase();
  }
}

@immutable
final class _StyleIcon extends StatelessWidget {
  const _StyleIcon({required this.style});

  final ImageAIStyle style;

  @override
  Widget build(BuildContext context) {
    final isNoStyle = style == ImageAIStyle.noStyle;

    return Container(
      padding: VPadding.all() / 3,
      decoration: BoxDecoration(
        color: isNoStyle
            ? ColorName.gray.withValues(alpha: 0.1)
            : ColorName.primary.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        _getIconData(style),
        color: isNoStyle ? ColorName.gray : ColorName.primary,
        size: 26,
      ),
    );
  }

  IconData _getIconData(ImageAIStyle style) {
    return switch (style) {
      ImageAIStyle.noStyle => Icons.image_not_supported_outlined,
      ImageAIStyle.anime => Icons.animation,
      ImageAIStyle.cyberPunk => Icons.memory,
      ImageAIStyle.oilPainting ||
      ImageAIStyle.kandinskyPainter ||
      ImageAIStyle.picassoPainter => Icons.brush,
      ImageAIStyle.render3D => Icons.view_in_ar,
      ImageAIStyle.cartoon || ImageAIStyle.sovietCartoon => Icons.face,
      ImageAIStyle.studioPhoto ||
      ImageAIStyle.portraitPhoto => Icons.camera_alt,
      ImageAIStyle.christmas => Icons.ac_unit,
      _ => Icons.palette_outlined,
    };
  }
}
