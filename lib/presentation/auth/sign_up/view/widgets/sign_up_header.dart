part of '../sign_up_view.dart';

@immutable
final class SignUpHeader extends StatelessWidget {
  const SignUpHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        VHeaderText(text: StringConstants.labelCreateAccount),
        VSizedBox.verticalBox16,
      ],
    );
  }
}
