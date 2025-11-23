part of '../chat_view.dart';

@immutable
final class _MessageList extends StatelessWidget {
  const _MessageList({
    required this.messages,
    required this.controller,
  });

  final List<ChatMessage> messages;
  final ScrollController controller;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      padding: VPadding.all(),
      itemCount: messages.length,
      itemBuilder: (context, index) {
        final msg = messages[index];
        return _MessageBubble(message: msg);
      },
    );
  }
}