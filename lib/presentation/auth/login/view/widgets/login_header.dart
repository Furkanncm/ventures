part of '../login_view.dart';

@immutable
final class LoginHeader extends StatelessWidget {
  const LoginHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        VHeaderText(text: StringConstants.labelWelcomeBack),
        VSizedBox.verticalBox16,
      ],
    );
  }
}
