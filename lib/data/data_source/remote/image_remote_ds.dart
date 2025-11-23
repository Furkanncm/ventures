import 'package:flutter/foundation.dart';
import 'package:stability_image_generation/stability_image_generation.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/env_type.dart';
import 'package:ventures/common/utils/enum/feature_type.dart';
import 'package:ventures/common/utils/enum/pref_keys.dart';
import 'package:ventures/common/utils/extensions/env_extension.dart';
import 'package:ventures/data/data_source/remote/store_remote_ds.dart';
import 'package:ventures/domain/cache/cache_repository.dart';

class ImageRemoteDS {
  ImageRemoteDS(
    this.storeRemoteDS,
  );

  final IStorageRemoteDS storeRemoteDS;

  final ai = StabilityAI();
  final String? apiKey = EnvType.stabilityApiKey.value;
  final ImageAIStyle imageAIStyle = ImageAIStyle.studioPhoto;

  Future<Uint8List> generateImage(String prompt) async {
    if (apiKey == null) throw Exception('Stablitiy api key not found');
    final result = await ai.generateImage(
      prompt: prompt,
      apiKey: apiKey!,
      imageAIStyle: imageAIStyle,
    );
    return result;
  }

  String? get uid =>
      CacheRepository.instance.getString(PrefKeys.isUserLoggedIn);

  Future<void> incrementUserFreeUsage() async {
    if (uid == null) throw Exception(StringConstants.noUserLoggedIn);
    await storeRemoteDS.incrementUsage(uid!, FeatureType.imageGeneration);
  }
}
