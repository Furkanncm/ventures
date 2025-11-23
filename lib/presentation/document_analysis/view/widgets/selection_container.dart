part of '../document_analysis_view.dart';

@immutable
final class _SelectionContainer extends StatelessWidget {
  const _SelectionContainer({
    required this.state,
    required this.onTap,
  });

  final DocumentAnalysisState state;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        height: 220,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: ColorName.gray.withValues(alpha: 0.5),
            width: 1.5,
          ),
          image: (state.selectedBytes != null && state.mimeType == 'image/jpeg')
              ? DecorationImage(
                  image: MemoryImage(state.selectedBytes!),
                  fit: BoxFit.fill,
                )
              : null,
        ),
        child: _PreviewContent(state: state),
      ),
    );
  }
}
