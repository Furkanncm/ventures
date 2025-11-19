part of '../image_view.dart';

@immutable
final class _InputCard extends StatelessWidget {
  const _InputCard({
    required this.controller,
  });

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Padding(
        padding: VPadding.all(),
        child: VTextField(
          controller: controller,
          label: StringConstants.promptLabel,
          maxLines: 2,
        ),
      ),
    );
  }
}
