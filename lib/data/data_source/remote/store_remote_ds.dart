import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ventures/common/base/base_remote_response.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/collection_type.dart';
import 'package:ventures/common/utils/enum/feature_type.dart'; // FeatureType Enum'ı
import 'package:ventures/common/utils/enum/subscription_type.dart'; // SubscriptionType Enum'ı
import 'package:ventures/data/model/user/user_info.dart';

abstract class IStorageRemoteDS {
  Future<BaseRemoteResponse<UserInfoModel?>> getUser(String uid);
  Future<BaseRemoteResponse<void>> setUser(UserInfoModel user);
  Future<BaseRemoteResponse<void>> reportError(String uid, String error);
  Future<BaseRemoteResponse<void>> incrementUsage(String uid, FeatureType type);
  Future<BaseRemoteResponse<void>> upgradeToPremium(String uid);
}

class StorageRemoteDS implements IStorageRemoteDS {
  StorageRemoteDS({FirebaseFirestore? firestore})
    : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference get _users =>
      _firestore.collection(CollectionType.users.value);

  @override
  Future<BaseRemoteResponse<UserInfoModel?>> getUser(String uid) async {
    return safeCall(() async {
      final doc = await _users.doc(uid).get();
      if (!doc.exists) {
        return BaseRemoteResponse(
          data: null,
          success: false,
          message: StringConstants.errorUserNotFound,
          statusCode: 404,
        );
      }
      return BaseRemoteResponse(
        data: UserInfoModel.fromJson(doc.data()! as Map<String, dynamic>),
        success: true,
        message: StringConstants.userFetchedSuccessfully,
        statusCode: 200,
      );
    });
  }

  @override
  Future<BaseRemoteResponse<void>> setUser(UserInfoModel user) async {
    return safeCall(() async {
      await _users.doc(user.uid).set(user.toJson(), SetOptions(merge: true));
      return BaseRemoteResponse(
        data: null,
        success: true,
        message: StringConstants.userUpdatedSuccessfully,
        statusCode: 200,
      );
    });
  }


  @override
  Future<BaseRemoteResponse<void>> reportError(String uid, String error) async {
    return safeCall(() async {
      await _users.doc(uid).update({
        'errorReports': FieldValue.arrayUnion([error]),
      });
      return BaseRemoteResponse(
        data: null,
        success: true,
        message: StringConstants.errorReported,
        statusCode: 200,
      );
    });
  }


  @override
  Future<BaseRemoteResponse<void>> incrementUsage(
    String uid,
    FeatureType type,
  ) async {
    return safeCall(() async {
      String fieldToUpdate;

      // Hangi alanı güncelleyeceğimizi Enum'a göre belirliyoruz
      switch (type) {
        case FeatureType.imageGeneration:
          fieldToUpdate = 'imageGenUsage';
        case FeatureType.textToSpeech:
          fieldToUpdate = 'ttsUsage';
        case FeatureType.documentAnalysis:
          fieldToUpdate = 'docAnalysisUsage';
      }

      // Firestore'da sadece o alanı 1 artırıyoruz (Atomik işlem)
      await _users.doc(uid).update({
        fieldToUpdate: FieldValue.increment(1),
      });

      return BaseRemoteResponse(
        data: null,
        success: true,
        message: 'Usage incremented successfully',
        statusCode: 200,
      );
    });
  }

  @override
  Future<BaseRemoteResponse<void>> upgradeToPremium(String uid) async {
    return safeCall(() async {
      await _users.doc(uid).update({
        'subscriptionType': SubscriptionType.premium.name, // Enum string değeri
      });

      return BaseRemoteResponse(
        data: null,
        success: true,
        message: 'Upgraded to premium successfully',
        statusCode: 200,
      );
    });
  }

  Future<BaseRemoteResponse<T>> safeCall<T>(
    Future<BaseRemoteResponse<T>> Function() action,
  ) async {
    try {
      return await action();
    } catch (e) {
      return BaseRemoteResponse(
        data: null,
        success: false,
        message: e.toString(),
        statusCode: 500,
      );
    }
  }
}
