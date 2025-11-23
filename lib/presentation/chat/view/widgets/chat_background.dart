part of '../chat_view.dart';

@immutable
final class _ChatBackground extends StatelessWidget {
  const _ChatBackground({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: CustomBoxDecoration.chatGradient(),
      child: child,
    );
  }
}
