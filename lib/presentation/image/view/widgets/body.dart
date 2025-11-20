part of '../image_view.dart';

@immutable
final class _Body extends StatelessWidget {
  const _Body({
    required this.state,
    required this.onPressed,
    required this.controller,
    required this.onSharePressed,
  });

  final ImageGenerationState state;
  final Future<void> Function()? onPressed;
  final VoidCallback onSharePressed;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: VPadding.pagePadding(),
      child: Column(
        spacing: 24,
        children: [
          _InputCard(controller: controller),
          VElevatedButton.fullWith(
            onPressed: () async {
              FocusScope.of(context).unfocus();
              await onPressed?.call();
            },
            label: StringConstants.generateButtonLabel,
          ),
          _ImageField(state: state, onSharePressed: onSharePressed),
        ],
      ),
    );
  }
}
