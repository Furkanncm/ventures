import 'package:ventures/common/base/base_remote_response.dart';
import 'package:ventures/data/model/user/user_info.dart';
import 'package:ventures/data/data_source/remote/store_remote_ds.dart';

abstract class IUserRepository {
  Future<BaseRemoteResponse<UserInfoModel?>> getUser(String uid);
  Future<BaseRemoteResponse<void>> setUser(UserInfoModel user);
  Future<BaseRemoteResponse<void>> addHistoryItem(String uid, String itemId);
  Future<BaseRemoteResponse<void>> addPublicItem(String uid, String itemId);
  Future<BaseRemoteResponse<void>> reportError(String uid, String error);
  Future<BaseRemoteResponse<List<String>>> getPublicItems(String uid);
  Future<BaseRemoteResponse<List<String>>> getHistoryItems(String uid);
}

class UserRepository implements IUserRepository {
  UserRepository(this._remoteDS);
  final StoreRemoteDS _remoteDS;

  @override
  Future<BaseRemoteResponse<UserInfoModel?>> getUser(String uid) {
    return _remoteDS.getUser(uid);
  }

  @override
  Future<BaseRemoteResponse<void>> setUser(UserInfoModel user) {
    return _remoteDS.setUser(user);
  }

  @override
  Future<BaseRemoteResponse<void>> addHistoryItem(String uid, String itemId) {
    return _remoteDS.addHistoryItem(uid, itemId);
  }

  @override
  Future<BaseRemoteResponse<void>> addPublicItem(String uid, String itemId) {
    return _remoteDS.addPublicItem(uid, itemId);
  }

  @override
  Future<BaseRemoteResponse<void>> reportError(String uid, String error) {
    return _remoteDS.reportError(uid, error);
  }

  @override
  Future<BaseRemoteResponse<List<String>>> getPublicItems(String uid) {
    return _remoteDS.getPublicItems(uid);
  }

  @override
  Future<BaseRemoteResponse<List<String>>> getHistoryItems(String uid) {
    return _remoteDS.getHistoryItems(uid);
  }
}
