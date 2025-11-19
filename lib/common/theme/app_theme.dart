import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:ventures/common/utils/padding/lg_padding.dart';
import 'package:ventures/common/widgets/text/v_text.dart';

final class AppLightTheme {
  ThemeData get themeData => _themeData;

  final ThemeData _themeData = ThemeData(
    useMaterial3: true,

    // ==== Scaffold ====
    scaffoldBackgroundColor: ColorName.backgroundLight,

    // ==== Color Scheme ====
    colorScheme: const ColorScheme.light(
      primary: ColorName.primary,
      secondary: ColorName.secondary,
      onSecondary: ColorName.onSecondary,
      tertiary: ColorName.tertiary,
      onTertiary: ColorName.onTertiary,
      error: ColorName.onError,
      outline: ColorName.gray,
    ),

    // ==== AppBar ====
    appBarTheme: const AppBarTheme(
      elevation: 0,
      centerTitle: true,
      backgroundColor: ColorName.backgroundLight,
      foregroundColor: ColorName.backgroundDark,
    ),

    // ==== TabBar ====
    tabBarTheme: const TabBarThemeData(
      labelColor: ColorName.primary,
      unselectedLabelColor: ColorName.gray,
      indicatorColor: ColorName.primary,
      dividerColor: Colors.transparent,
    ),

    // ==== Icon ====
    iconTheme: const IconThemeData(
      color: ColorName.backgroundDark,
      size: 28,
    ),

    // ==== Elevated Button ====
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorName.primary,
        foregroundColor: ColorName.onPrimary,
        padding: VPadding.elevatedButtonPadding(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
      ),
    ),

    // ==== TextButton ====
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: ColorName.primary,
        textStyle: TextStyle(
          fontSize: VTextStyleType.bodyMedium.fontSize,
        ),
      ),
    ),

    // ==== Outlined Button ====
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: const VPadding.outlinedPadding(),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        side: BorderSide(
          color: ColorName.gray.withValues(alpha: 0.5),
          width: 1.2,
        ),
      ),
    ),

    // ==== Divider ====
    dividerTheme: DividerThemeData(
      color: ColorName.gray.withValues(alpha: 0.4),
      thickness: 1,
    ),

    // ==== Input Fields ====
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: ColorName.white,
      labelStyle: TextStyle(
        fontSize: VTextStyleType.bodySmall.fontSize,
        color: ColorName.gray,
      ),
      contentPadding: const VPadding.outlinedPadding(),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: ColorName.gray.withValues(alpha: 0.3),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: ColorName.gray.withValues(alpha: 0.4),
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(
          color: ColorName.primary,
          width: 1.6,
        ),
      ),
    ),

    // ==== Text Theme (opsiyonel ama önerilir) ====
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontSize: VTextStyleType.headlineLarge.fontSize,
        fontWeight: FontWeight.bold,
        color: ColorName.backgroundDark,
      ),
      bodyMedium: TextStyle(
        fontSize: VTextStyleType.bodyMedium.fontSize,
        color: ColorName.backgroundDark,
      ),
      bodySmall: TextStyle(
        fontSize: VTextStyleType.bodySmall.fontSize,
        color: ColorName.gray,
      ),
    ),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: ColorName.white,
      elevation: 8,
      type: BottomNavigationBarType.fixed,

      selectedItemColor: ColorName.primary,
      unselectedItemColor: ColorName.gray,

      selectedIconTheme: const IconThemeData(
        color: ColorName.primary,
        size: 28,
      ),
      unselectedIconTheme: IconThemeData(
        color: ColorName.gray.withValues(alpha: 0.8),
        size: 26,
      ),

      selectedLabelStyle: TextStyle(
        fontSize: VTextStyleType.bodySmall.fontSize,
        fontWeight: FontWeight.w600,
        color: ColorName.primary,
      ),
      unselectedLabelStyle: TextStyle(
        fontSize: VTextStyleType.bodySmall.fontSize,
        color: ColorName.gray.withValues(alpha: 0.8),
      ),
    ),
    dialogTheme: DialogThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      backgroundColor: ColorName.onSecondary,
      actionsPadding: VPadding.all(),
    ),
  );
}
