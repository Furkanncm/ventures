part of '../login_view.dart';

@immutable
final class LoginFooter extends StatelessWidget {
  const LoginFooter({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        VSizedBox.verticalBox16,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const VText(StringConstants.labelHaveAccount),
            GestureDetector(
              onTap: () {
                router.goNamed(RoutePaths.signUp.name);
              },
              child: const VText(
                StringConstants.labelSignUp,
                color: ColorName.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
