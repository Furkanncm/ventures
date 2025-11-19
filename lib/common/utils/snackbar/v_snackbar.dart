import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:ventures/common/utils/enum/snackbar_type.dart';
import 'package:ventures/common/utils/padding/lg_padding.dart';
import 'package:ventures/common/widgets/sized_box/v_sized_box.dart';
import 'package:ventures/common/widgets/text/v_text.dart';

final class VSnackBar {
  VSnackBar._();

  static int _count = 0;

  static void show({
    required BuildContext context,
    required String text,
    required SnackBarType type,
  }) {
    _countSnackBar(context);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        behavior: SnackBarBehavior.fixed,
        content: Container(
          padding: VPadding.pagePadding(),
          decoration: BoxDecoration(
            color: _setBackgroundColor(type),
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: _setBackgroundColor(type).withValues(alpha: 0.15),
                blurRadius: 12,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              _setIcon(type),
              VSizedBox.horizontalBox8,
              Expanded(
                child: VText(
                  text,
                  color: ColorName.backgroundLight,
                ),
              ),
            ],
          ),
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static Color _setBackgroundColor(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return ColorName.onSuccess;
      case SnackBarType.error:
        return ColorName.onError;
      case SnackBarType.info:
        return ColorName.primary;
      case SnackBarType.warning:
        return ColorName.tertiary;
    }
  }

  static void _hide(BuildContext context) {
    ScaffoldMessenger.of(context).clearSnackBars();
  }

  static Icon _setIcon(SnackBarType type) {
    IconData icon;
    switch (type) {
      case SnackBarType.success:
        icon = Icons.check_circle_outline_outlined;
      case SnackBarType.error:
        icon = Icons.error_outline;
      case SnackBarType.info:
        icon = Icons.info_outline;
      case SnackBarType.warning:
        icon = Icons.warning_amber_outlined;
    }
    return Icon(icon, color: ColorName.onSecondary);
  }

  static void _countSnackBar(BuildContext context) {
    if (_count == 0) {
      _count++;
    } else {
      _count = 0;
      _hide(context);
    }
  }
}
