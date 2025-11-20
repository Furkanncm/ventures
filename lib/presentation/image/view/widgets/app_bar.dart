part of '../image_view.dart';

@immutable
final class _AppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AppBar({required this.onRouteHistory});
  final VoidCallback onRouteHistory;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      elevation: 0,
      title: const VText(
        StringConstants.imageGeneratorTitle,
        type: VTextStyleType.titleLarge,
      ),
      centerTitle: true,
      actions: [
        IconButton(
          onPressed: onRouteHistory,
          icon: const Icon(Icons.history_outlined),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
