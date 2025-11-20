part of '../image_view.dart';

@immutable
final class _ImageField extends StatelessWidget {
  const _ImageField({
    required this.state,
    required this.onSharePressed,
  });

  final ImageGenerationState state;
  final VoidCallback onSharePressed; 

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
            : Stack(
                fit: StackFit.expand,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.memory(
                      state.imageUrl!,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 12,
                    right: 12,
                    child: Material(
                      color: Colors.black.withOpacity(
                        0.5,
                      ), 
                      borderRadius: BorderRadius.circular(30),
                      child: InkWell(
                        borderRadius: BorderRadius.circular(30),
                        onTap: onSharePressed,
                        child: const Padding(
                          padding: EdgeInsets.all(10),
                          child: Icon(
                            Icons.share_rounded,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
    );
  }
}
