part of '../sign_up_view.dart';

@immutable
final class SignUpButtons extends StatelessWidget {
  const SignUpButtons({
    required this.onEmailRegisterPressed,
    required this.onGoogleRegisterPressed,
    super.key,
  });

  final void Function() onEmailRegisterPressed;
  final void Function() onGoogleRegisterPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VElevatedButton.fullWith(
          onPressed: onEmailRegisterPressed,
          label: StringConstants.labelSignUp,
        ),
        VSizedBox.verticalBox12,
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onGoogleRegisterPressed,
            icon: Assets.image.icGoogle.toIcon,
            label: const VText(
              StringConstants.labelSignUpWithGoogle,
              type: VTextStyleType.bodyLarge,
            ),
          ),
        ),
      ],
    );
  }
}
