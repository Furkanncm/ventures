import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/common/utils/enum/feature_type.dart';
import 'package:ventures/domain/image/image_repository.dart';
import 'package:ventures/presentation/image/viewmodel/image_generation_state.dart';

class ImageGenerationNotifier extends StateNotifier<ImageGenerationState> {
  ImageGenerationNotifier(this.repo, this.ref)
    : super(const ImageGenerationState());

  final IImageRepository repo;
  final Ref ref;

  Future<bool> generate(String prompt) async {
    if (state.error != null) {
      state = state.copyWith();
    }
    try {
      state = state.copyWith(loading: true);
      final (bytes, imageFile) = await repo.generateImage(prompt);

      // Profildeki sayacı artır
      ref
          .read(profileNotifierProvider.notifier)
          .incrementLocalUsage(FeatureType.imageGeneration);

      state = state.copyWith(
        loading: false,
        imageUrl: bytes,
        imageFile: imageFile,
      );
      return true;
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
    return false;
  }
}
