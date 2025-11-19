import 'package:flutter_riverpod/legacy.dart';
import 'package:ventures/domain/image/image_repository.dart';
import 'package:ventures/presentation/image/viewmodel/image_generation_state.dart';

class ImageGenerationNotifier extends StateNotifier<ImageGenerationState> {
  ImageGenerationNotifier(this.repo) : super(ImageGenerationState());
  final IImageRepository repo;

  Future<void> generate(String prompt) async {
    try {
      state = state.copyWith(loading: true);
      final url = await repo.generateImage(prompt);
      state = state.copyWith(loading: false, imageUrl: url);
    } catch (e) {
      state = state.copyWith(loading: false, error: e.toString());
    }
  }
}
