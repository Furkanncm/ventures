part of '../chat_view.dart';

@immutable
final class _ChatAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _ChatAppBar({required this.onClear});

  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: ColorName.backgroundLight,
      elevation: 0,
      forceMaterialTransparency: true,
      title: const Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundColor: ColorName.primary,
            radius: 18,
            child: Icon(Icons.auto_awesome),
          ),
          VSizedBox.horizontalBox12,
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VText(
                StringConstants.chatTitle,
                type: VTextStyleType.titleMedium,
                fontWeight: FontWeight.bold,
              ),
              VText(
                StringConstants.online,
                color: ColorName.onSuccess,
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.delete_outline_rounded),
          onPressed: onClear,
          tooltip: StringConstants.clearChat,
          color: ColorName.onError,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
