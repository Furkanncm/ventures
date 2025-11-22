import 'package:ventures/common/base/base_remote_response.dart';
import 'package:ventures/common/utils/enum/feature_type.dart';
import 'package:ventures/data/data_source/remote/store_remote_ds.dart';
import 'package:ventures/data/model/user/user_info.dart';

abstract class IUserRepository {
  // --- Current User Erişimi ---
  UserInfoModel? get currentUser;

  // --- DÜZELTME: Bu satırı eklemeyi unutmuşum ---
  /// Repository içindeki kullanıcı verisini manuel olarak günceller.
  void setCurrentUser(UserInfoModel? user);
  // ---------------------------------------------

  Future<BaseRemoteResponse<UserInfoModel?>> getUser(String uid);
  Future<BaseRemoteResponse<void>> setUser(UserInfoModel user);
  Future<BaseRemoteResponse<void>> reportError(String uid, String error);
  Future<BaseRemoteResponse<void>> incrementUsage(String uid, FeatureType type);
  Future<BaseRemoteResponse<void>> upgradeToPremium(String uid);

  // Çıkış yapınca user'ı temizlemek için
  void clearCurrentUser();
}

class UserRepository implements IUserRepository {
  UserRepository(this._remoteDS);
  final StorageRemoteDS _remoteDS;

  // --- Local Değişken (RAM'de tutulan kullanıcı) ---
  UserInfoModel? _currentUser;

  @override
  UserInfoModel? get currentUser => _currentUser;

  // --- DÜZELTME: Metodun Gövdesi ---
  @override
  void setCurrentUser(UserInfoModel? user) {
    _currentUser = user;
  }
  // --------------------------------

  @override
  void clearCurrentUser() {
    _currentUser = null;
  }

  @override
  Future<BaseRemoteResponse<UserInfoModel?>> getUser(String uid) async {
    final response = await _remoteDS.getUser(uid);

    // KRİTİK: Veri başarılı geldiyse local değişkene set et.
    if ((response.success ?? false) && response.data != null) {
      _currentUser = response.data;
    }

    return response;
  }

  @override
  Future<BaseRemoteResponse<void>> setUser(UserInfoModel user) async {
    // Güncellerken de local değişkeni anında güncelle
    _currentUser = user;
    return _remoteDS.setUser(user);
  }

  @override
  Future<BaseRemoteResponse<void>> incrementUsage(
    String uid,
    FeatureType type,
  ) async {
    if (_currentUser != null) {
      _currentUser = _currentUser!.consumeCredit(type);
    }
    // Sonra Firebase'e gönder
    return _remoteDS.incrementUsage(uid, type);
  }

  @override
  Future<BaseRemoteResponse<void>> upgradeToPremium(String uid) async {
    if (_currentUser != null) {
      _currentUser = _currentUser!.upgradeToPremium();
    }
    return _remoteDS.upgradeToPremium(uid);
  }

  @override
  Future<BaseRemoteResponse<void>> reportError(String uid, String error) {
    return _remoteDS.reportError(uid, error);
  }
}
