import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ventures/common/dialog/v_dialog.dart';
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/snackbar_type.dart';
import 'package:ventures/common/utils/extensions/future_extension.dart';
import 'package:ventures/common/utils/snackbar/v_snackbar.dart';
import 'package:ventures/data/model/document_analysis/document_analysis_record.dart';
import 'package:ventures/domain/download/download_repository.dart';
import 'package:ventures/domain/pdf/pdf_repository.dart';
import 'package:ventures/domain/share/share_repository.dart';

mixin DocumentHistoryMixin on ConsumerWidget {
  Future<void> showDetail(
    BuildContext context,
    DocumentAnalysisRecord record,
  ) async {
    await VDialogs.documentDetailDialog(context: context, record: record);
  }

  Future<void> shareRecord(
    BuildContext context,
    DocumentAnalysisRecord record,
  ) async {
    final pdfFile = await PdfService.generateAnalysisPdf(
      content: record.resultText,
      title:
          '${StringConstants.analyzeDocument} - ${DateFormat(StringConstants.dateFormat).format(record.createdAt)}',
    ).withLoading(context);

    await ShareRepository.instance.shareDocument(pdfFile.path);
  }

  Future<void> downloadRecord(
    BuildContext context,
    DocumentAnalysisRecord record,
  ) async {
    try {
      final pdfFile = await PdfService.generateAnalysisPdf(
        content: record.resultText,
        title: StringConstants.analyzeDocument,
      ).withLoading(context);

      var finalName =
          '${StringConstants.analyzeDocument}${record.id.substring(0, 8)}';

      if (record.fileName != null && record.fileName!.isNotEmpty) {
        var name = record.fileName!;
        if (name.contains('.')) {
          name = name.substring(0, name.lastIndexOf('.'));
        }
        finalName = name;
      }

      final success = await DownloadRepository.instance.saveDocumentToDevice(
        filePath: pdfFile.path,
        fileName: finalName,
      );

      if (!context.mounted) return;
      if (success) {
        VSnackBar.show(
          context: context,
          text: '${StringConstants.downloadSuccess}: $finalName.pdf',
          type: SnackBarType.success,
        );
      } else {
        VSnackBar.show(
          context: context,
          text: StringConstants.downloadFail,
          type: SnackBarType.error,
        );
      }
    } catch (e) {
      VSnackBar.show(
        context: context,
        text: '${StringConstants.errorGeneric}: $e',
        type: SnackBarType.error,
      );
    }
  }

  Future<void> deleteRecord(
    BuildContext context,
    WidgetRef ref,
    DocumentAnalysisRecord record,
  ) async {
    final _ = await VDialogs.confirmationDialog(
      context: context,
      title: StringConstants.deleteAnalysisTitle,
      content: StringConstants.deleteAnalysisContent,
      positiveButtonLabel: StringConstants.delete,
      onPositiveButton: () async {
        await ref.read(historyRepositoryProvider).deleteDocumentRecord(record);
        final _ = ref.refresh(documentHistoryListProvider);
      },
    );
  }
}
