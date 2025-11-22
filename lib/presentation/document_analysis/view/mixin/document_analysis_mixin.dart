import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventures/common/bottom_sheet/v_bottom_sheets.dart';
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/common/router/router.dart';
import 'package:ventures/common/utils/enum/route_path.dart';
import 'package:ventures/common/utils/enum/snackbar_type.dart';
import 'package:ventures/common/utils/extensions/future_extension.dart';
import 'package:ventures/common/utils/snackbar/v_snackbar.dart';
import 'package:ventures/domain/pdf/pdf_repository.dart';
import 'package:ventures/domain/share/share_repository.dart';
import 'package:ventures/presentation/document_analysis/view/document_analysis_view.dart';
import 'package:ventures/presentation/document_analysis/viewmodel/document_analysis_notifier.dart';
import 'package:ventures/presentation/document_analysis/viewmodel/document_anaysis_state.dart';

mixin DocumentAnalysisMixin on ConsumerState<DocumentAnalysisView> {
  final TextEditingController promptController = TextEditingController();

  @override
  void dispose() {
    promptController.dispose();
    super.dispose();
  }

  void useDocumentListener() {
    ref.listen(documentAnalysisProvider, (prev, next) {
      if (next.error != null) {
        VSnackBar.show(
          context: context,
          text: next.error!,
          type: SnackBarType.error,
        );
      }
    });
  }

  DocumentAnalysisState get state => ref.watch(documentAnalysisProvider);

  DocumentAnalysisNotifier get notifier =>
      ref.read(documentAnalysisProvider.notifier);

  Future<void> onAnalyzePressed() async {
    FocusScope.of(context).unfocus();
    await notifier
        .analyzeDocument(promptController.text.trim())
        .withLoading(context);
  }

  void routeHistory() {
    router.goNamed(RoutePaths.documentHistory.name);
  }

  Future<void> onSourceTap() async {
    await VBottomSheets.showImageSourceSheet(
      context: context,
      onCameraTap: () => notifier.pickImage(fromCamera: true),
      onGalleryTap: () => notifier.pickImage(fromCamera: false),
      onPdfTap: () => notifier.pickFile(),
    );
  }

  Future<void> onShareResultTap() async {
    final resultText = state.analysisResult;
    if (resultText == null || resultText.isEmpty) return;
    final pdfFile = await PdfService.generateAnalysisPdf(
      content: resultText,
    ).withLoading(context);
    await ShareRepository.instance.shareDocument(pdfFile.path);
  }
}
