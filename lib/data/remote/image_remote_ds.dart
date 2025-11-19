import 'package:flutter/foundation.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:stability_image_generation/stability_image_generation.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/pref_keys.dart';
import 'package:ventures/data/remote/store_remote_ds.dart';
import 'package:ventures/domain/cache/cache_repository.dart';

class ImageRemoteDS {
  ImageRemoteDS(
    this.storeRemoteDS,
  );

  final IStoreRemoteDS storeRemoteDS;

  final ai = StabilityAI();
  final String? apiKey = dotenv.env['STABILITY_AI_API_KEY'];
  final ImageAIStyle imageAIStyle = ImageAIStyle.digitalPainting;

  Future<Uint8List> generateImage(String prompt) async {
    if (apiKey == null) throw Exception('Stablitiy api key not found');
    final result = await ai.generateImage(
      prompt: prompt,
      apiKey: apiKey!,
      imageAIStyle: imageAIStyle,
    );
    await incrementUserFreeUsage();
    return result;
  }

  String? get uid =>
      CacheRepository.instance.getString(PrefKeys.isUserLoggedIn);

  // / Saves item data inside the user document (storage A).
  // Future<Map<String, dynamic>> saveItemToUserDoc({
  //   required String url,
  //   required String prompt,
  //   required bool isPublic,
  // }) async {
  //   final user = auth.currentUser;
  //   if (user == null) throw Exception('Not authenticated');

  //   final id = const Uuid().v4();
  //   final item = {
  //     'id': id,
  //     'url': url,
  //     'prompt': prompt,
  //     'ownerId': user.uid,
  //     'isPublic': isPublic,
  //     'createdAt': FieldValue.serverTimestamp(),
  //   };

  //   final userRef = firestore.collection('users').doc(user.uid);

  //   // Append to historyItems array
  //   await firestore.runTransaction((tx) async {
  //     final snap = await tx.get(userRef);
  //     if (!snap.exists) {
  //       tx.set(userRef, {
  //         'historyItems': [item],
  //         'publicItems': isPublic ? [item] : [],
  //       }, SetOptions(merge: true));
  //     } else {
  //       tx.update(userRef, {
  //         'historyItems': FieldValue.arrayUnion([item]),
  //       });
  //       if (isPublic)
  //         tx.update(userRef, {
  //           'publicItems': FieldValue.arrayUnion([item]),
  //         });
  //     }
  //   });

  //   return item;
  // }

  Future<void> incrementUserFreeUsage() async {
    if (uid == null) throw Exception(StringConstants.noUserLoggedIn);
    await storeRemoteDS.incrementUserFreeUsage(uid!);
  }
}
