import 'package:flutter/material.dart';

/// A utility class that provides commonly used [SizedBox] constants
/// for consistent spacing throughout the app.
///
/// Use this class to avoid magic numbers in UI layouts and
/// to ensure a unified spacing scale across widgets.
///
/// Example usage:
/// ```dart
/// Column(
///   children: [
///     Text('Title'),
///     LgSizedBox.verticalBox16,
///     Text('Subtitle'),
///   ],
/// );
/// ```
///
/// Naming conventions:
/// - `verticalBoxX`: vertical spacing (height = X)
/// - `horizontalBoxX`: horizontal spacing (width = X)
/// - `extraSmall`, `small`, `medium`, etc.: square boxes 
final class VSizedBox {
  VSizedBox._();

  /// An empty [SizedBox] — equivalent to `SizedBox.shrink()`.
  static const emptyBox = SizedBox.shrink();

  /// A 4×4 [SizedBox].
  static const extraSmall = SizedBox(width: 4, height: 4);

  /// An 8×8 [SizedBox].
  static const small = SizedBox(width: 8, height: 8);

  /// A 16×16 [SizedBox].
  static const medium = SizedBox(width: 16, height: 16);

  /// A 24×24 [SizedBox].
  static const large = SizedBox(width: 24, height: 24);

  /// A 32×32 [SizedBox].
  static const extraLarge = SizedBox(width: 32, height: 32);

  // Vertical spacing boxes
  static const verticalBox4 = SizedBox(height: 4);
  static const verticalBox8 = SizedBox(height: 8);
  static const verticalBox12 = SizedBox(height: 12);
  static const verticalBox16 = SizedBox(height: 16);
  static const verticalBox24 = SizedBox(height: 24);
  static const verticalBox32 = SizedBox(height: 32);
  static const verticalBox48 = SizedBox(height: 48);

  // Horizontal spacing boxes
  static const horizontalBox4 = SizedBox(width: 4);
  static const horizontalBox8 = SizedBox(width: 8);
  static const horizontalBox12 = SizedBox(width: 12);
  static const horizontalBox16 = SizedBox(width: 16);
  static const horizontalBox24 = SizedBox(width: 24);
  static const horizontalBox32 = SizedBox(width: 32);
  static const horizontalBox48 = SizedBox(width: 48);
}
