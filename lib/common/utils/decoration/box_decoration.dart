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
  CustomBoxDecoration.errorContainer()
    : super(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(8),
        border: Border.all(
          color: ColorName.onError.withValues(alpha: 0.3),
        ),
      );
  CustomBoxDecoration.shareButton()
    : super(
        color: ColorName.gray.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: ColorName.gray.withValues(alpha: 0.3),
        ),
      );

  CustomBoxDecoration.chatGradient()
    : super(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            ColorName.backgroundLight,
            ColorName.primary.withValues(alpha: 0.05),
          ],
        ),
      );
}
