import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:ventures/common/widgets/button/v_elevated_button.dart';
import 'package:ventures/common/widgets/text/v_text.dart';

part 'widgets/base_dialog.dart';
part 'widgets/dialog_icon.dart';
part 'widgets/dlalog_buttons.dart';

abstract class NewsAppDialogs {
  NewsAppDialogs._();

  static Future<bool?> confirmationDialog({
    required BuildContext context,
    required VoidCallback onPositiveButton,
    required String title,
    required String content,
    String positiveButtonLabel = 'Yes',
    String negativeButtonLabel = 'No',
  }) async {
    return showAdaptiveDialog<bool>(
      context: context,
      builder: (context) {
        return _BaseDialog(
          title: title,
          content: content,
          onPositiveButton: onPositiveButton,
          negativeButtonLabel: negativeButtonLabel,
          positiveButtonLabel: positiveButtonLabel,
        );
      },
    );
  }
}
