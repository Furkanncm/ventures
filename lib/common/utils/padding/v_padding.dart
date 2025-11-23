import 'package:flutter/material.dart';
import 'package:ventures/common/utils/enum/v_value.dart';

final class VPadding extends EdgeInsets {
  const VPadding.zeroPadding() : super.all(0);

  VPadding.pagePadding()
    : super.symmetric(
        horizontal: VValue.medium.value,
        vertical: VValue.large.value,
      );

  VPadding.horizontalMediumPadding()
    : super.symmetric(
        horizontal: VValue.medium.value,
      );

  VPadding.verticalMediumPadding()
    : super.symmetric(
        vertical: VValue.medium.value,
      );

  VPadding.all() : super.all(VValue.medium.value);
  VPadding.elevatedButtonPadding()
    : super.symmetric(
        vertical: VValue.medium.value,
        horizontal: VValue.large.value,
      );

  const VPadding.outlinedPadding()
    : super.symmetric(
        horizontal: 12,
        vertical: 16,
      );
      const VPadding.messageBubblePadding()
    : super.symmetric(
        horizontal: 16,
        vertical: 12,
      );

  const VPadding.cardPadding() : super.symmetric(horizontal: 16, vertical: 8);

  const VPadding.onlyBottomPadding(): super.only(bottom: 12);
}
