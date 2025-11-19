import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';

@immutable
final class CustomBoxDecoration extends BoxDecoration {
  const CustomBoxDecoration.lineerGradient()
    : super(
        gradient: const LinearGradient(
          colors: [ColorName.primary, ColorName.onPrimary],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      );
  const CustomBoxDecoration.blackToTransparent()
    : super(
        gradient: const LinearGradient(
          colors: [
            ColorName.backgroundDark,
            Colors.transparent,
          ],
          begin: Alignment.bottomCenter,
          end: Alignment.topCenter,
        ),
      );
}
