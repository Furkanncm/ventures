part of '../image_history_view.dart';

@immutable
final class ImageHistoryEmpty extends StatelessWidget {
  const ImageHistoryEmpty({required this.onRefresh, super.key});
  final Future<void> Function() onRefresh;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      child: ListView(
        children: const [
          SizedBox(
            height: 300,
            child: Center(
              child: VText(StringConstants.noSavedImages),
            ),
          ),
        ],
      ),
    );
  }
}
