import 'package:flutter/material.dart';
import 'package:ventures/common/utils/enum/v_value.dart';

/// A utility class that provides standardized [EdgeInsets] paddings
/// for consistent layout spacing throughout the app.
///
/// This class extends [EdgeInsets] and offers named constructors
/// to apply commonly used padding configurations based on
/// predefined [VValue] spacing constants.
///
/// Example usage:
/// ```dart
/// Padding(
///   padding: LgPadding.pagePadding(),
///   child: Text('Hello World'),
/// );
/// ```
///
/// Available constructors:
/// - `LgPadding.zeroPadding()` → No padding.
/// - `LgPadding.pagePadding()` → Medium horizontal + Large vertical padding.
/// - `LgPadding.horizontalMediumPadding()` → Medium horizontal padding only.
/// - `LgPadding.verticalMediumPadding()` → Medium vertical padding only.
/// - `LgPadding.all()` → Equal medium padding on all sides.
final class VPadding extends EdgeInsets {
  /// Creates an [EdgeInsets] with zero padding.
  const VPadding.zeroPadding() : super.all(0);

  /// Creates a symmetric padding:
  /// - horizontal: `LgValue.medium`
  /// - vertical: `LgValue.large`
  VPadding.pagePadding()
    : super.symmetric(
        horizontal: VValue.medium.value,
        vertical: VValue.large.value,
      );

  /// Creates horizontal padding with `LgValue.medium` spacing.
  VPadding.horizontalMediumPadding()
    : super.symmetric(
        horizontal: VValue.medium.value,
      );

  /// Creates vertical padding with `LgValue.medium` spacing.
  VPadding.verticalMediumPadding()
    : super.symmetric(
        vertical: VValue.medium.value,
      );

  /// Creates uniform padding on all sides using `LgValue.medium`.
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
}
