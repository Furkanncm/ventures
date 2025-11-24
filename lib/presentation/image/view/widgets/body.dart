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
    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: VPadding.pagePadding(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        spacing: 24,
        children: [
          InputCard(controller: controller),
          VElevatedButton.withIconAndFullWith(
            onPressed: () async {
              FocusScope.of(context).unfocus();
              await onPressed?.call();
            },
            icon: const Icon(Icons.gradient),
            label: StringConstants.generateButtonLabel,
          ),
          const StyleSelector(),
          _ImageField(state: state, onSharePressed: onSharePressed),
          VSizedBox.verticalBox48,
        ],
      ),
    );
  }
}
