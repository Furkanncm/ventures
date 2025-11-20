part of '../text_to_speech_history_view.dart';

@immutable
final class _EmptyHistoryView extends StatelessWidget {
  const _EmptyHistoryView();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.history_edu, size: 80, color: Colors.grey.shade300),
          VSizedBox.verticalBox16,
          const VText(StringConstants.noAudioRecordedYet),
        ],
      ),
    );
  }
}
