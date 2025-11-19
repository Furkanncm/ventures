import 'package:flutter/material.dart';
import 'package:ventures/common/widgets/text/v_text.dart';

@immutable
final class VHeaderText extends StatelessWidget {
  const VHeaderText({
    required this.text,
    super.key,
    this.textAlign = TextAlign.start,
    this.fontWeight = FontWeight.bold,
    this.maxLines = 1,
  });

  final String text;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final int maxLines;

  @override
  Widget build(BuildContext context) {
    return VText(
      text,
      type: VTextStyleType.headlineSmall,
      fontWeight: fontWeight,
      textAlign: textAlign,
      maxLines: maxLines,
    );
  }
}
