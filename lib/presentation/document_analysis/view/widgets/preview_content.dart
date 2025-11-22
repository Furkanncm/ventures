part of '../document_analysis_view.dart';

@immutable
final class _PreviewContent extends StatelessWidget {
  const _PreviewContent({required this.state});

  final DocumentAnalysisState state;

  @override
  Widget build(BuildContext context) {
    if (state.selectedBytes == null) {
      return const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.upload_file_rounded,
            size: 50,
            color: ColorName.primary,
          ),
          VSizedBox.verticalBox12,
          VText(
            StringConstants.tapToSelectDoc,
            type: VTextStyleType.bodyLarge,
            color: ColorName.gray,
          ),
        ],
      );
    }

    if (state.mimeType == 'application/pdf') {
      return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.picture_as_pdf_rounded,
            size: 60,
            color: ColorName.onError,
          ),
          VSizedBox.verticalBox12,
          const VText(
            StringConstants.pdfSelected,
            type: VTextStyleType.titleMedium,
            fontWeight: FontWeight.bold,
          ),
          VSizedBox.verticalBox4,
          VText(
            '${(state.selectedBytes!.length / 1024).toStringAsFixed(1)} KB',
            color: ColorName.gray,
          ),
        ],
      );
    }

    return const SizedBox.shrink();
  }
}
