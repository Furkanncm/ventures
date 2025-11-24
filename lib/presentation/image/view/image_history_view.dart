import 'dart:io';
import 'dart:typed_data';

import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventures/common/dialog/v_dialog.dart';
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/feature_type.dart';
import 'package:ventures/common/utils/padding/v_padding.dart';
import 'package:ventures/common/widgets/appbar/v_app_bar.dart';
import 'package:ventures/common/widgets/other/no_history_found.dart';
import 'package:ventures/common/widgets/sized_box/v_sized_box.dart';
import 'package:ventures/presentation/image/view/mixin/image_history_mixin.dart';

part 'widgets/image_card_item.dart';
part 'widgets/image_grid.dart';

@immutable
final class ImageHistoryView extends ConsumerStatefulWidget {
  const ImageHistoryView({super.key});

  @override
  ConsumerState<ImageHistoryView> createState() => _ImageHistoryViewState();
}

class _ImageHistoryViewState extends ConsumerState<ImageHistoryView>
    with ImageHistoryMixin {
  @override
  Widget build(BuildContext context) {
    final imagesAsync = ref.watch(imageHistoryProvider);

    return Scaffold(
      appBar: const VAppbar(title: StringConstants.imageHistoryTitle),
      body: imagesAsync.when(
        data: (images) {
          if (images.isEmpty) {
            return const NotFound(type: FeatureType.imageGeneration);
          }
          return ImageGrid(
            images: images,
            onRefresh: () async => ref.refresh(imageHistoryProvider),
            onDelete: onDeletePressed,
            onShare: onSharePressed,
            onDownload: onDownloadPressed,
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, _) => Center(child: Text('Error: $err')),
      ),
    );
  }
}
