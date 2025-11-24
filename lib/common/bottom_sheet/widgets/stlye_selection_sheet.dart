part of '../v_bottom_sheets.dart';

@immutable
final class _StyleSelectionSheet extends StatelessWidget {
  const _StyleSelectionSheet({
    required this.selectedStyle,
    required this.onStyleSelected,
  });

  final ImageAIStyle selectedStyle;
  final ValueChanged<ImageAIStyle> onStyleSelected;

  @override
  Widget build(BuildContext context) {
    const styles = ImageAIStyle.values;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const _SheetHeader(title: StringConstants.imageSelectStyle),

        Flexible(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            itemCount: styles.length,
            separatorBuilder: (_, __) => const Divider(height: 1, indent: 60),
            itemBuilder: (context, index) {
              final style = styles[index];
              final isSelected = style == selectedStyle;

              return InkWell(
                onTap: () => onStyleSelected(style),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const VPadding.outlinedPadding(),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ColorName.primary.withValues(alpha: 0.05)
                        : null,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: VPadding.all(),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? ColorName.primary.withValues(alpha: 0.1)
                              : ColorName.gray.withValues(alpha: 0.1),
                          shape: BoxShape.circle,
                        ),
                        child: Icon(
                          _getIconForStyle(style),
                          color: isSelected
                              ? ColorName.primary
                              : ColorName.gray,
                        ),
                      ),

                      VSizedBox.horizontalBox12,

                      Expanded(
                        child: Text(
                          _formatStyleName(style),
                          style: TextStyle(
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.w500,
                            fontSize: 16,
                            color: isSelected ? ColorName.primary : null,
                          ),
                        ),
                      ),

                      if (isSelected)
                        const Icon(
                          Icons.check_circle_rounded,
                          color: ColorName.primary,
                        ),
                    ],
                  ),
                ),
              );
            },
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

  IconData _getIconForStyle(ImageAIStyle style) {
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
