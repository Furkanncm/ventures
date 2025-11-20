import 'package:ventures/common/base/base_remote_response.dart';
import 'package:ventures/common/utils/enum/feature_type.dart'; // Enum'ı import et
import 'package:ventures/data/data_source/remote/store_remote_ds.dart';
import 'package:ventures/data/model/user/user_info.dart';

abstract class IUserRepository {
  Future<BaseRemoteResponse<UserInfoModel?>> getUser(String uid);
  Future<BaseRemoteResponse<void>> setUser(UserInfoModel user);
  Future<BaseRemoteResponse<void>> reportError(String uid, String error);

  // --- YENİ EKLENENLER ---
  /// İlgili özelliğin kullanım hakkını 1 azaltır (sayacı artırır).
  Future<BaseRemoteResponse<void>> incrementUsage(String uid, FeatureType type);

  /// Kullanıcıyı Premium'a yükseltir.
  Future<BaseRemoteResponse<void>> upgradeToPremium(String uid);
}

class UserRepository implements IUserRepository {
  UserRepository(this._remoteDS);
  final StorageRemoteDS _remoteDS;

  @override
  Future<BaseRemoteResponse<UserInfoModel?>> getUser(String uid) {
    return _remoteDS.getUser(uid);
  }

  @override
  Future<BaseRemoteResponse<void>> setUser(UserInfoModel user) {
    return _remoteDS.setUser(user);
  }

  @override
  Future<BaseRemoteResponse<void>> reportError(String uid, String error) {
    return _remoteDS.reportError(uid, error);
  }

  // --- YENİ IMPLEMENTASYONLAR ---

  @override
  Future<BaseRemoteResponse<void>> incrementUsage(
    String uid,
    FeatureType type,
  ) {
    // İşi Data Source'a devrediyoruz
    return _remoteDS.incrementUsage(uid, type);
  }

  @override
  Future<BaseRemoteResponse<void>> upgradeToPremium(String uid) {
    // İşi Data Source'a devrediyoruz
    return _remoteDS.upgradeToPremium(uid);
  }
}
