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

  CustomBoxDecoration.aiGradient()
      : super(
          shape: BoxShape.circle,
          gradient: LinearGradient(
            colors: [
              ColorName.primary,
              ColorName.primary.withValues(alpha: 0.7),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: ColorName.primary.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 6),
              spreadRadius: 2,
            ),
          ],
        );

  CustomBoxDecoration.messageDecoration({required bool isUser})
      : super(
          color: isUser ? ColorName.primary : ColorName.backgroundLight,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(20),
            topRight: const Radius.circular(20),
            bottomLeft: isUser
                ? const Radius.circular(20)
                : const Radius.circular(4),
            bottomRight: isUser
                ? const Radius.circular(4)
                : const Radius.circular(20),
          ),
        );
}