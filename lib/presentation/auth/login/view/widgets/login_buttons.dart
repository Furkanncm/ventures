part of '../login_view.dart';

@immutable
final class LoginButtons extends StatelessWidget {
  const LoginButtons({
    required this.onEmailLoginPressed,
    required this.onGoogleLoginPressed,
    super.key,
  });

  final void Function() onEmailLoginPressed;
  final void Function() onGoogleLoginPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VElevatedButton.fullWith(
          onPressed: onEmailLoginPressed,
          label: StringConstants.labelLogin,
        ),
        VSizedBox.verticalBox12,
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onGoogleLoginPressed,
            icon: Assets.image.icGoogle.toIcon,
            label: const VText(
              StringConstants.labelLoginWithGoogle,
              type: VTextStyleType.bodyLarge,
            ),
          ),
        ),
      ],
    );
  }
}
