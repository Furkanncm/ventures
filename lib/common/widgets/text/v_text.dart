import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';

enum VTextStyleType {
  headlineLarge(36),
  headlineMedium(32),
  headlineSmall(28),
  titleLarge(24),
  titleMedium(20),
  titleSmall(18),
  bodyLarge(16),
  bodyMedium(14),
  bodySmall(12);

  const VTextStyleType(this.fontSize);
  final double fontSize;
}

final class VText extends StatelessWidget {
  const VText(
    this.text, {
    super.key,
    this.type = VTextStyleType.bodyMedium,
    this.color,
    this.fontWeight = FontWeight.normal,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
    this.overflow = TextOverflow.ellipsis,
  });

  final String text;
  final VTextStyleType type;
  final Color? color;
  final FontWeight fontWeight;
  final int? maxLines;
  final TextAlign textAlign;
  final TextOverflow overflow;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      maxLines: maxLines,
      overflow: overflow,
      textAlign: textAlign,
      style: TextStyle(
        
        color:
            color ??
            (Theme.brightnessOf(context) == Brightness.light
                ? ColorName.backgroundDark
                : ColorName.backgroundLight),
        fontSize: type.fontSize,
        fontWeight: fontWeight,
      ),
    );
  }
}
