import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:ventures/common/widgets/sized_box/v_sized_box.dart';
import 'package:ventures/common/widgets/text/v_text.dart';

final class VElevatedButton extends StatelessWidget {
  const VElevatedButton({
    required this.label,
    required this.onPressed,
    this.isWithIcon = false,
    this.isCentered = false,
    this.icon,
    super.key,
  });

  const VElevatedButton.withIcon({
    required this.label,
    required this.icon,
    required this.onPressed,
    this.isCentered = false,
    super.key,
  }) : isWithIcon = true;

  const VElevatedButton.fullWith({
    required this.label,
    required this.onPressed,
    this.icon,
    this.isWithIcon = false,
    super.key,
  }) : isCentered = true;

  const VElevatedButton.withIconAndFullWith({
    required this.label,
    required this.onPressed,
    required this.icon,
    super.key,
  }) : isCentered = true,
       isWithIcon = true;

  final String label;
  final bool isWithIcon;
  final bool isCentered;
  final VoidCallback? onPressed;
  final Widget? icon;

  @override
  Widget build(BuildContext context) {
    final labelWidget = VText(
      label,
      type: VTextStyleType.bodyLarge,
      color: ColorName.backgroundLight,
    );
    final rowWidget = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        labelWidget,
        VSizedBox.horizontalBox8,
        if (isWithIcon) icon! else VSizedBox.emptyBox,
      ],
    );
    return ElevatedButton(
      onPressed: onPressed,
      child: isCentered ? Center(child: rowWidget) : rowWidget,
    );
  }
}
