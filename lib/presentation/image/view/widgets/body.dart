part of '../image_view.dart';

@immutable
final class _Body extends StatelessWidget {
  const _Body({
    required this.state,
    required this.onPressed,
    required this.controller,
  });

  final ImageGenerationState state;
  final Future<void> Function()? onPressed;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: VPadding.pagePadding(),
      child: Column(
        children: [
          _InputCard(controller: controller),
          VSizedBox.verticalBox24,
          VElevatedButton.fullWith(
            onPressed: onPressed,
            label: StringConstants.generateButtonLabel,
          ),
          VSizedBox.verticalBox24,
          _ImageField(state: state),
        ],
      ),
    );
  }
}
