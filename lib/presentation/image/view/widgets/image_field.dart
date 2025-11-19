part of '../image_view.dart';

@immutable
final class _ImageField extends StatelessWidget {
  const _ImageField({
    required this.state,
  });

  final ImageGenerationState state;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: AnimatedSwitcher(
        duration: const Duration(milliseconds: 500),
        child: state.imageUrl == null
            ? Center(
                child: VText(
                  state.error ?? StringConstants.noImageMessage,
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.memory(
                  state.imageUrl!,
                  fit: BoxFit.cover,
                ),
              ),
      ),
    );
  }
}
