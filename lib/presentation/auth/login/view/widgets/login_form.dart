part of '../login_view.dart';

@immutable
final class LoginForm extends StatelessWidget {
  const LoginForm({
    required this.formKey,
    required this.emailController,
    required this.passwordController,
    super.key,
  });

  final GlobalKey<FormState> formKey;
  final TextEditingController emailController;
  final TextEditingController passwordController;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          VTextField.email(controller: emailController),
          VSizedBox.verticalBox16,
          VTextField.password(controller: passwordController),
        ],
      ),
    );
  }
}
