import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/decoration/box_decoration.dart';
import 'package:ventures/common/utils/padding/v_padding.dart';
import 'package:ventures/common/widgets/text/v_text.dart';
import 'package:ventures/presentation/image/view/mixin/image_history_mixin.dart';

part 'widgets/empty_image.dart';
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
      appBar: AppBar(
        forceMaterialTransparency: true,
        title: const VText(
          StringConstants.imageHistoryTitle,
          type: VTextStyleType.titleLarge,
        ),
        centerTitle: true,
      ),
      body: imagesAsync.when(
        data: (images) {
          if (images.isEmpty) {
            return ImageHistoryEmpty(
              onRefresh: () async {
                final _=ref.refresh(imageHistoryProvider);
              },
            );
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
