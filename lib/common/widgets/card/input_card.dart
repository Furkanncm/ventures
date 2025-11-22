import 'package:flutter/material.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/padding/v_padding.dart';
import 'package:ventures/common/widgets/textfied/v_textfield.dart';

@immutable
final class InputCard extends StatelessWidget {
  const InputCard({
    required this.controller,
    this.maxLines = 3,
    super.key,
  });

  final TextEditingController controller;
  final int maxLines;

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
          maxLines: maxLines,
        ),
      ),
    );
  }
}
