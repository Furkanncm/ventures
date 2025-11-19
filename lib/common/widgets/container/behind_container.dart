import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';

@immutable
final class BehindContainer extends StatelessWidget {
  const BehindContainer({
    required this.isCurrentIndex,
    required this.selectedIcon,
    required this.unSelectedIcon,
    super.key,
  });

  final bool isCurrentIndex;
  final IconData selectedIcon;
  final IconData unSelectedIcon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 40,
      width: 40,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: isCurrentIndex
            ? ColorName.primary.withValues(alpha: 0.1)
            : null,
      ),
      child: Icon(isCurrentIndex ? selectedIcon : unSelectedIcon),
    );
  }
}