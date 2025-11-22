import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/padding/v_padding.dart';
import 'package:ventures/common/widgets/appbar/v_app_bar.dart';
import 'package:ventures/common/widgets/sized_box/v_sized_box.dart';
import 'package:ventures/common/widgets/text/v_fadded_text.dart';
import 'package:ventures/common/widgets/text/v_text.dart';
import 'package:ventures/data/model/text_to_speech/audio_record.dart';
import 'package:ventures/presentation/text_to_speech/view/mixin/text_to_speech_history_mixin.dart';

part 'widgets/empty_history.dart';
part 'widgets/item_card_history.dart';

@immutable
final class AudioHistoryView extends ConsumerStatefulWidget {
  const AudioHistoryView({super.key});

  @override
  ConsumerState<AudioHistoryView> createState() => _AudioHistoryViewState();
}

class _AudioHistoryViewState extends ConsumerState<AudioHistoryView>
    with AudioHistoryMixin {
  @override
  Widget build(BuildContext context) {
    final historyAsync = ref.watch(historyListProvider);

    return Scaffold(
      appBar: const VAppbar(title: StringConstants.audioHistoryTitle),
      body: historyAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) =>
            Center(child: Text('${StringConstants.errorReported}: $err')),
        data: (historyList) {
          if (historyList.isEmpty) {
            return const _EmptyHistoryView();
          }

          return ListView.separated(
            padding: VPadding.all(),
            itemCount: historyList.length,
            separatorBuilder: (context, index) => VSizedBox.verticalBox12,
            itemBuilder: (context, index) {
              final record = historyList[index];

              final isPlaying = playingRecordId == record.id;

              return _HistoryItemCard(
                record: record,
                isPlaying: isPlaying,
                onPlayTap: () => togglePlay(record),
                onDeleteTap: () => deleteRecord(record),
                onShareTap: () => shareRecord(record),
                onDownloadTap: () => downloadRecord(record),
              );
            },
          );
        },
      ),
    );
  }
}
