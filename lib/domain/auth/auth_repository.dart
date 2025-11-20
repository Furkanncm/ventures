import 'package:ventures/common/base/base_remote_response.dart';
import 'package:ventures/common/utils/enum/pref_keys.dart';
import 'package:ventures/data/model/user/user_auth.dart';
import 'package:ventures/data/model/user/user_info.dart';
import 'package:ventures/data/data_source/remote/auth_remote_ds.dart';
import 'package:ventures/data/data_source/remote/store_remote_ds.dart';
import 'package:ventures/domain/cache/cache_repository.dart';

abstract class IAuthRepository {
  Future<BaseRemoteResponse<AuthUser>> registerWithEmail({
    required String email,
    required String password,
    String? displayName,
  });
  Future<BaseRemoteResponse<AuthUser>> loginWithEmail({
    required String email,
    required String password,
  });
  Future<BaseRemoteResponse<AuthUser>> loginWithGoogle();
  Future<BaseRemoteResponse<void>> logout();
  BaseRemoteResponse<AuthUser> getCurrentUser();
}

class AuthRepository implements IAuthRepository {
  AuthRepository({
    required IAuthRemoteDS authRemoteDS,
    required IStoreRemoteDS storeRemoteDS,
  }) : _authRemoteDS = authRemoteDS,
       _storeRemoteDS = storeRemoteDS;

  final IAuthRemoteDS _authRemoteDS;
  final IStoreRemoteDS _storeRemoteDS;

  /// ---------------------------
  /// SharedPreferences helper
  /// ---------------------------
  Future<void> _setUserLoggedIn(String? uid) async {
    if (uid == null) return;
    await CacheRepository.instance.setString(PrefKeys.isUserLoggedIn, uid);
  }

  /// ---------------------------
  /// Register
  /// ---------------------------
  @override
  Future<BaseRemoteResponse<AuthUser>> registerWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    final response = await _authRemoteDS.registerWithEmail(
      email: email,
      password: password,
      displayName: displayName,
    );

    if ((response.success ?? false) && response.data != null) {
      final userInfo = UserInfoModel(
        uid: response.data!.uid,
        displayName: response.data!.displayName ?? '',
        email: response.data!.email ?? '',
      );
      await _storeRemoteDS.setUser(userInfo);

      await _setUserLoggedIn(response.data?.uid);
    }

    return response;
  }

  /// ---------------------------
  /// Login Email
  /// ---------------------------
  @override
  Future<BaseRemoteResponse<AuthUser>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final response = await _authRemoteDS.loginWithEmail(
      email: email,
      password: password,
    );

    if ((response.success ?? false) && response.data != null) {
      await _setUserLoggedIn(response.data?.uid);
    }

    return response;
  }

  /// ---------------------------
  /// Login Google
  /// ---------------------------
  @override
  Future<BaseRemoteResponse<AuthUser>> loginWithGoogle() async {
    final response = await _authRemoteDS.loginWithGoogle();

    if ((response.success ?? false) && response.data != null) {
      final userInfo = UserInfoModel(
        uid: response.data!.uid,
        displayName: response.data!.displayName ?? '',
        email: response.data!.email ?? '',
        photoUrl: response.data!.photoUrl,
      );
      await _storeRemoteDS.setUser(userInfo);

      await _setUserLoggedIn(response.data?.uid);
    }

    return response;
  }

  /// ---------------------------
  /// Logout
  /// ---------------------------
  @override
  Future<BaseRemoteResponse<void>> logout() async {
    final response = await _authRemoteDS.logout();

    if (response.success ?? false) {
      await CacheRepository.instance.remove(PrefKeys.isUserLoggedIn);
    }

    return response;
  }

  /// ---------------------------
  /// Current User
  /// ---------------------------
  @override
  BaseRemoteResponse<AuthUser> getCurrentUser() {
    return _authRemoteDS.getCurrentUser();
  }
}
