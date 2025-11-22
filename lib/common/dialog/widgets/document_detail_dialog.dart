part of '../v_dialog.dart';

class _DocumentDetailDialog extends StatelessWidget {
  const _DocumentDetailDialog({required this.record});

  final DocumentAnalysisRecord record;

  @override
  Widget build(BuildContext context) {
    final isPdf = record.imagePath?.endsWith('.pdf') ?? false;
    final hasImage =
        record.imagePath != null && File(record.imagePath!).existsSync();

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      elevation: 10,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      insetPadding: VPadding.all(),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: VPadding.all(),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const VText(
                  StringConstants.analysisDetailsTitle,
                  type: VTextStyleType.titleMedium,
                  fontWeight: FontWeight.bold,
                ),
                IconButton(
                  icon: const Icon(Icons.close_rounded),
                  onPressed: () => Navigator.pop(context),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          Flexible(
            child: SingleChildScrollView(
              padding: VPadding.all(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      height: 180,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: Theme.of(context).cardColor,
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: (hasImage && !isPdf)
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: Image.file(
                                File(record.imagePath!),
                                fit: BoxFit.cover,
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  isPdf
                                      ? Icons.picture_as_pdf_rounded
                                      : Icons.description_rounded,
                                  size: 64,
                                  color: isPdf
                                      ? ColorName.onError
                                      : ColorName.primary,
                                ),
                                const SizedBox(height: 12),
                                VText(
                                  isPdf
                                      ? StringConstants.pdfDocument
                                      : StringConstants.noPreviewAvailable,
                                  color: ColorName.gray,
                                ),
                              ],
                            ),
                    ),
                  ),

                  VSizedBox.verticalBox24,

                  const VText(
                    StringConstants.analysisResult,
                    type: VTextStyleType.bodyLarge,
                    fontWeight: FontWeight.w600,
                    color: ColorName.gray,
                  ),

                  VSizedBox.verticalBox12,

                  Container(
                    padding: VPadding.all(),
                    decoration: BoxDecoration(
                      color:
                          Theme.of(
                            context,
                          ).colorScheme.surfaceContainerHighest.withValues(
                            alpha: .3,
                          ),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: MarkdownBody(
                      data: record.resultText,
                      selectable: true,
                      styleSheet:
                          MarkdownStyleSheet.fromTheme(
                            Theme.of(context),
                          ).copyWith(
                            p: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              height: 1.5,
                            ),
                          ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: VPadding.all(),
            child: VElevatedButton(
              onPressed: () => Navigator.pop(context),
              label: StringConstants.close,
            ),
          ),
        ],
      ),
    );
  }
}
