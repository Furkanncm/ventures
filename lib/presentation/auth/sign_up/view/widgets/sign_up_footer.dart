part of '../sign_up_view.dart';

@immutable
final class SignUpFooter extends StatelessWidget {
  const SignUpFooter({super.key});

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
                router.goNamed(RoutePaths.login.name);
              },
              child: const VText(
                StringConstants.labelLogin,
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
