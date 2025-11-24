import 'dart:io';

import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/feature_type.dart';
import 'package:ventures/common/utils/padding/v_padding.dart';
import 'package:ventures/common/widgets/appbar/v_app_bar.dart';
import 'package:ventures/common/widgets/other/no_history_found.dart';
import 'package:ventures/common/widgets/sized_box/v_sized_box.dart';
import 'package:ventures/common/widgets/text/v_fadded_text.dart';
import 'package:ventures/common/widgets/text/v_text.dart';
import 'package:ventures/data/model/document_analysis/document_analysis_record.dart';
import 'package:ventures/presentation/document_analysis/view/mixin/document_analysis_history_mixin.dart';

part 'widgets/document_history_item.dart';

class DocumentHistoryView extends ConsumerWidget with DocumentHistoryMixin {
  const DocumentHistoryView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final historyAsync = ref.watch(documentHistoryListProvider);

    return Scaffold(
      appBar: const VAppbar(title: StringConstants.analysisHistoryTitle),
      body: historyAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) =>
            Center(child: VText('${StringConstants.errorGeneric}: $err')),
        data: (records) {
          if (records.isEmpty)
            {
              return const NotFound(type: FeatureType.documentAnalysis);
            }

          return ListView.separated(
            padding: VPadding.all(),
            itemCount: records.length,
            separatorBuilder: (_, __) => VSizedBox.verticalBox12,
            itemBuilder: (context, index) {
              final record = records[index];
              return _DocumentHistoryItem(
                record: record,
                onTap: () => showDetail(context, record),
                onDelete: () => deleteRecord(context, ref, record),
                onShare: () => shareRecord(context, record),
                onDownload: () => downloadRecord(context, record),
              );
            },
          );
        },
      ),
    );
  }
}
