import 'package:flutter/material.dart';
import 'package:ventures/common/widgets/text/v_text.dart';

@immutable
final class VAppbar extends StatelessWidget implements PreferredSizeWidget {
  const VAppbar({
    required this.title,
    super.key,
    this.actions,
  });

  final String title;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      forceMaterialTransparency: true,
      centerTitle: true,
      title: VText(
        title,
        type: VTextStyleType.titleLarge,
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
