import 'package:ventures/common/base/base_remote_response.dart';
import 'package:ventures/common/utils/enum/share_prefs_keys.dart';
import 'package:ventures/data/data_source/remote/auth_remote_ds.dart';
import 'package:ventures/data/data_source/remote/store_remote_ds.dart';
import 'package:ventures/data/model/user/user_auth.dart';
import 'package:ventures/data/model/user/user_info.dart';
import 'package:ventures/domain/shared_pref/share_pref_manager.dart';

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
    required IStorageRemoteDS storeRemoteDS,
  }) : _authRemoteDS = authRemoteDS,
       _storeRemoteDS = storeRemoteDS;

  final IAuthRemoteDS _authRemoteDS;
  final IStorageRemoteDS _storeRemoteDS;


  Future<void> _setUserLoggedIn(String? uid) async {
    if (uid == null) return;
    await SharedPrefsManager().setString(SharedPrefsKeys.isUserLoggedIn, uid);
  }

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
      final uid = response.data!.uid!;

      final userInfo = UserInfoModel(
        uid: uid,
        displayName: response.data!.displayName ?? '',
        email: response.data!.email ?? '',
      );
      await _storeRemoteDS.setUser(userInfo);

      await _setUserLoggedIn(uid);
    }

    return response;
  }


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


  @override
  Future<BaseRemoteResponse<AuthUser>> loginWithGoogle() async {
    final response = await _authRemoteDS.loginWithGoogle();

    if ((response.success ?? false) && response.data != null) {
      final uid = response.data!.uid!;

      final userCheck = await _storeRemoteDS.getUser(uid);

      if (userCheck.success ?? false ) {
        await _setUserLoggedIn(uid);
      } else {
        final userInfo = UserInfoModel(
          uid: uid,
          displayName: response.data!.displayName ?? '',
          email: response.data!.email ?? '',
          photoUrl: response.data!.photoUrl,
        );
        await _storeRemoteDS.setUser(userInfo);
        await _setUserLoggedIn(uid);
      }
    }

    return response;
  }


  @override
  Future<BaseRemoteResponse<void>> logout() async {
    final response = await _authRemoteDS.logout();

    if (response.success ?? false) {
      await SharedPrefsManager().remove(SharedPrefsKeys.isUserLoggedIn);
    }

    return response;
  }

  @override
  BaseRemoteResponse<AuthUser> getCurrentUser() {
    return _authRemoteDS.getCurrentUser();
  }
}
