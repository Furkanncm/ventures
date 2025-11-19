import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/extensions/string_extension.dart';
import 'package:ventures/common/utils/validator/validators.dart';

@immutable
final class VTextField extends StatefulWidget {
  const VTextField({
    required this.label,
    required this.controller,
    this.prefixIcon,
    this.suffixIcon,
    this.reverseSuffixIcon,
    this.validator,
    this.obscureText = false,
    this.keyboardType = TextInputType.text,
    this.onDatePick,
    this.maxLines = 1,
    super.key,
  });

  const VTextField.email({
    required this.controller,
    super.key,
  }) : label = StringConstants.labelEmail,
       validator = Validators.emailValidator,
       prefixIcon = Icons.email_outlined,
       suffixIcon = null,
       reverseSuffixIcon = null,
       keyboardType = TextInputType.emailAddress,
       obscureText = false,
       onDatePick = null,
       maxLines = 1;

  const VTextField.password({
    required this.controller,
    super.key,
  }) : label = StringConstants.labelPassword,
       validator = Validators.passwordValidator,
       prefixIcon = Icons.lock_outline_rounded,
       suffixIcon = Icons.visibility_off_outlined,
       reverseSuffixIcon = Icons.visibility_outlined,
       keyboardType = TextInputType.visiblePassword,
       obscureText = true,
       maxLines = 1,
       onDatePick = null;

  const VTextField.confirmPassword({
    required this.controller,
    required this.validator,
    super.key,
  }) : label = StringConstants.labelConfirmPassword,
       prefixIcon = Icons.lock_outline_rounded,
       suffixIcon = Icons.visibility_off_outlined,
       reverseSuffixIcon = Icons.visibility_outlined,
       keyboardType = TextInputType.visiblePassword,
       obscureText = true,
       maxLines = 1,
       onDatePick = null;

  final String label;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final IconData? reverseSuffixIcon;
  final TextEditingController controller;
  final String? Function(String? value)? validator;
  final bool obscureText;
  final TextInputType keyboardType;
  final void Function(DateTime? dateTime)? onDatePick;
  final int maxLines;

  @override
  State<VTextField> createState() => _VTextFieldState();
}

class _VTextFieldState extends State<VTextField> {
  late final FocusNode _focusNode;
  bool _isFocused = false;
  late bool _isObscureText;
  bool hasText = false;

  @override
  void initState() {
    _isObscureText = widget.obscureText;
    _focusNode = FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
    widget.controller.addListener(() {
      setState(() {});
    });
    super.initState();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  void changeObscureText() {
    setState(() {
      _isObscureText = !_isObscureText;
    });
  }

  @override
  Widget build(BuildContext context) {
    hasText = widget.controller.text.isNotNullOrNotEmpty;
    final inputDecorationTheme = Theme.of(context).inputDecorationTheme;
    return TextFormField(
      focusNode: _focusNode,
      maxLines: widget.maxLines,
      controller: widget.controller,
      obscureText: _isObscureText,
      validator: widget.validator,
      decoration: InputDecoration(
        prefixIcon: widget.prefixIcon == null
            ? null
            : Icon(
                widget.prefixIcon,
                color: _isFocused
                    ? ColorName.primary
                    : ColorName.gray.withValues(alpha: 0.5),
              ),
        suffixIcon:
            widget.suffixIcon == null && widget.reverseSuffixIcon == null
            ? null
            : IconButton(
                onPressed: changeObscureText,
                icon: Icon(
                  _isObscureText ? widget.reverseSuffixIcon : widget.suffixIcon,
                  color: _isFocused
                      ? ColorName.backgroundDark
                      : ColorName.gray.withValues(alpha: 0.5),
                ),
              ),
        floatingLabelBehavior: FloatingLabelBehavior.auto,
        labelText: widget.label,
        labelStyle: inputDecorationTheme.labelStyle?.copyWith(
          color: _isFocused || hasText
              ? ColorName.primary
              : ColorName.gray.withValues(alpha: 0.5),
        ),
        enabledBorder: hasText
            ? inputDecorationTheme.focusedBorder
            : inputDecorationTheme.disabledBorder,
      ),
    );
  }
}
