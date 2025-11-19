part of '../profile_view.dart';

@immutable
final class _ProfileItemsList extends StatelessWidget {
  const _ProfileItemsList({
    required this.title,
    required this.items,
    required this.icon,
  });

  final String title;
  final List<String> items;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        VText(
          title,
          type: VTextStyleType.titleMedium,
        ),
        VSizedBox.verticalBox8,
        ...items.map(
          (item) => ListTile(
            leading: Icon(icon),
            title: VText(item),
          ),
        ),
      ],
    );
  }
}
