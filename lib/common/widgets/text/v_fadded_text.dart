import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:ventures/common/widgets/text/v_text.dart';

@immutable
final class LgFaddedText extends StatelessWidget {
  const LgFaddedText({
    required this.text,
    super.key,
    this.textStyleType = VTextStyleType.bodyMedium,
    this.maxLines = 1,
    this.textAlign = TextAlign.start,
  });

  final String text;
  final VTextStyleType textStyleType;
  final TextAlign textAlign;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return VText(
      text,
      type: textStyleType,
      color: ColorName.gray,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}
