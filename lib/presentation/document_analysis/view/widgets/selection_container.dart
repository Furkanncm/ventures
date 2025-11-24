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
    final isImage =
        state.selectedBytes != null &&
        (state.mimeType == 'image/jpeg' || state.mimeType == 'image/png');

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
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18), 
          child: Stack(
            fit: StackFit.expand,
            children: [
              if (isImage) ...[
                Image.memory(
                  state.selectedBytes!,
                  fit: BoxFit.cover,
                ),

                BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
                  child: Container(
                    color: ColorName.backgroundDark.withValues(alpha: 0.5),
                    alignment: Alignment.center,
                  ),
                ),

                Center(
                  child: Image.memory(
                    state.selectedBytes!,
                    fit: BoxFit.contain,
                  ),
                ),
              ] else
                _PreviewContent(state: state),
            ],
          ),
        ),
      ),
    );
  }
}
