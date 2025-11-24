import 'dart:io';

import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/padding/v_padding.dart';
import 'package:ventures/common/widgets/button/v_elevated_button.dart';
import 'package:ventures/common/widgets/sized_box/v_sized_box.dart';
import 'package:ventures/common/widgets/text/v_text.dart';
import 'package:ventures/data/model/document_analysis/document_analysis_record.dart';

part 'widgets/base_dialog.dart';
part 'widgets/dialog_icon.dart';
part 'widgets/dlalog_buttons.dart';
part 'widgets/full_image_dialog.dart';
part 'widgets/document_detail_dialog.dart';

abstract class VDialogs {
  VDialogs._();

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

  static Future<bool?> logOutDialog({
    required BuildContext context,

    required VoidCallback onPositiveButton,
    String positiveButtonLabel = StringConstants.logout,
    String negativeButtonLabel = 'No',
  }) async {
    return showAdaptiveDialog<bool>(
      context: context,
      builder: (context) {
        return _BaseDialog(
          title: StringConstants.logoutDialogTitle,
          content: StringConstants.logoutDialogContent,
          onPositiveButton: onPositiveButton,
          negativeButtonLabel: negativeButtonLabel,
          positiveButtonLabel: positiveButtonLabel,
        );
      },
    );
  }

  static Future<void> photoDialog({
    required BuildContext context,
    required File file,
  }) async {
    return showAdaptiveDialog<void>(
      context: context,
      barrierColor: Colors.transparent,
      builder: (context) => _FullImageDialog(file: file),
    );
  }

  static Future<void> documentDetailDialog({
    required BuildContext context,
    required DocumentAnalysisRecord record,
  }) async {
     await showDialog<void>(
      context: context,
      builder: (context) => _DocumentDetailDialog(record: record),
    );
  }

  static Future<bool?> exitAppDialog(BuildContext context) async {
    return showAdaptiveDialog<bool>(
      context: context,
      builder: (context) {
        return _BaseDialog(
          title: StringConstants.exitAppTitle,
          content: StringConstants.exitAppContent,
          onPositiveButton: () => Navigator.of(context).pop(true),
          negativeButtonLabel: StringConstants.cancel,
          positiveButtonLabel: StringConstants.exit,
        );
      },
    );
  }
}
