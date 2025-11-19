part of '../sign_up_view.dart';

@immutable
final class SignUpForm extends StatelessWidget {
  const SignUpForm({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    required this.displayNameController,
    required this.confirmPasswordController,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;
  final TextEditingController confirmPasswordController;
  final TextEditingController displayNameController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        spacing: 16,
        children: [
          VTextField(
            prefixIcon: Icons.person_2_outlined,
            controller: displayNameController,
            label: StringConstants.labelDisplayName,
          ),
          VTextField.email(controller: emailController),
          VTextField.password(controller: passwordController),
          VTextField.confirmPassword(
            controller: confirmPasswordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return StringConstants.errorConfirmPasswordEmpty;
              }
              if (value != passwordController.text) {
                return StringConstants.errorPasswordMismatch;
              }
              return null;
            },
          ),
        ],
      ),
    );
  }
}
