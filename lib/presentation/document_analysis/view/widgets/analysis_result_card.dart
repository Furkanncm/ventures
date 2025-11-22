part of '../document_analysis_view.dart';

@immutable
final class _AnalysisResultCard extends StatelessWidget {
  const _AnalysisResultCard({
    required this.result,
    required this.onShareTap,
  });

  final String result;
  final VoidCallback onShareTap; 

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: VPadding.all(),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest
            .withValues(alpha:.4), 
        borderRadius: BorderRadius.circular(24),
        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha:0.1),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const VText(
                StringConstants.analysisResult,
                type: VTextStyleType.titleMedium,
                fontWeight: FontWeight.bold,
              ),

              InkWell(
                onTap: onShareTap,
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  height: 48,
                  width: 48,
                  decoration: CustomBoxDecoration.shareButton(),
                  child: const Icon(Icons.share, color: ColorName.gray),
                ),
              ),
            ],
          ),

          VSizedBox.verticalBox16, 
          MarkdownBody(
            data: result,
            selectable: true,
            styleSheet:
                MarkdownStyleSheet.fromTheme(
                  Theme.of(context),
                ).copyWith(
                  p: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.6, 
                    fontSize: 15,
                  ),
                  h1: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                  h2: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
          ),
        ],
      ),
    );
  }
}
