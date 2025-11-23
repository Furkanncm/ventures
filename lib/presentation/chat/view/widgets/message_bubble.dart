part of '../chat_view.dart';

@immutable
final class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final isUser = message.isUser;

    return Padding(
      padding: const VPadding.onlyBottomPadding(),
      child: Row(
        mainAxisAlignment: isUser
            ? MainAxisAlignment.end
            : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            const CircleAvatar(
              radius: 16,
              backgroundColor: ColorName.secondary,
              child: Icon(
                Icons.smart_toy_rounded,
                size: 18,
                color: ColorName.backgroundLight,
              ),
            ),
            VSizedBox.horizontalBox8,
          ],
          Flexible(
            child: Container(
              padding: const VPadding.messageBubblePadding(),
              decoration: BoxDecoration(
                color: isUser ? ColorName.secondary : ColorName.backgroundLight,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: isUser
                      ? const Radius.circular(20)
                      : const Radius.circular(4),
                  bottomRight: isUser
                      ? const Radius.circular(4)
                      : const Radius.circular(20),
                ),
              ),
              child: VText(
                message.text,
                type: VTextStyleType.bodyLarge,
                maxLines: 15,
              ),
            ),
          ),
          if (isUser) VSizedBox.horizontalBox24,
        ],
      ),
    );
  }
}
