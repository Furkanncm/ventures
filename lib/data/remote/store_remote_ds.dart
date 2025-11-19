import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ventures/common/base/base_remote_response.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/collection_type.dart';
import 'package:ventures/data/model/user/user_info.dart';

abstract class IStoreRemoteDS {
  Future<BaseRemoteResponse<UserInfoModel?>> getUser(String uid);
  Future<BaseRemoteResponse<void>> setUser(UserInfoModel user);
  Future<BaseRemoteResponse<void>> addHistoryItem(String uid, String itemId);
  Future<BaseRemoteResponse<void>> addPublicItem(String uid, String itemId);
  Future<BaseRemoteResponse<void>> reportError(String uid, String error);
  Future<BaseRemoteResponse<List<String>>> getPublicItems(String uid);
  Future<BaseRemoteResponse<List<String>>> getHistoryItems(String uid);
  Future<void> incrementUserFreeUsage(String uid);
}

class StoreRemoteDS implements IStoreRemoteDS {
  StoreRemoteDS({FirebaseFirestore? firestore})
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
  Future<BaseRemoteResponse<void>> addHistoryItem(
    String uid,
    String itemId,
  ) async {
    return safeCall(() async {
      await _users.doc(uid).update({
        'historyItems': FieldValue.arrayUnion([itemId]),
      });
      return BaseRemoteResponse(
        data: null,
        success: true,
        message: StringConstants.historyItemAdded,
        statusCode: 200,
      );
    });
  }

  @override
  Future<BaseRemoteResponse<void>> addPublicItem(
    String uid,
    String itemId,
  ) async {
    return safeCall(() async {
      await _users.doc(uid).update({
        'publicItems': FieldValue.arrayUnion([itemId]),
      });
      return BaseRemoteResponse(
        data: null,
        success: true,
        message: StringConstants.publicItemAdded,
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
  Future<BaseRemoteResponse<List<String>>> getPublicItems(String uid) async {
    return safeCall(() async {
      final doc = await _users.doc(uid).get();
      final data = doc.data() as Map<String, dynamic>?;
      final items = data?['publicItems'] as List<dynamic>?;

      return BaseRemoteResponse(
        data: items?.map((e) => e.toString()).toList() ?? [],
        success: true,
        message: StringConstants.publicItemsFetched,
        statusCode: 200,
      );
    });
  }

  @override
  Future<BaseRemoteResponse<List<String>>> getHistoryItems(String uid) async {
    return safeCall(() async {
      final doc = await _users.doc(uid).get();
      final data = doc.data() as Map<String, dynamic>?;
      final items = data?['historyItems'] as List<dynamic>?;

      return BaseRemoteResponse(
        data: items?.map((e) => e.toString()).toList() ?? [],
        success: true,
        message: StringConstants.historyItemsFetched,
        statusCode: 200,
      );
    });
  }

  Future<void> incrementUserFreeUsage(String uid) async {
    final userRef = _users.doc(uid);
    await userRef.update({'freeUsageCount': FieldValue.increment(1)});
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
