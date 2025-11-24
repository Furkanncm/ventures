import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ventures/common/network/dio_manager.dart';
import 'package:ventures/common/utils/enum/share_prefs_keys.dart';
import 'package:ventures/domain/shared_pref/share_pref_manager.dart';
import 'package:ventures/domain/user/user_repository.dart';

enum SplashStatus { loading, authenticated, unauthenticated, error }

class SplashNotifier extends StateNotifier<SplashStatus> {
  SplashNotifier(this._userRepo, this._cacheRepo) : super(SplashStatus.loading);

  final IUserRepository _userRepo;
  final SharedPrefsManager _cacheRepo;

  Future<void> init() async {
    try {
      await Future<void>.delayed(const Duration(seconds: 1));
      await dotenv.load();

      await SharedPrefsManager().init();

      await DioManager().init();

      await _checkSession();
      await Future<void>.delayed(const Duration(seconds: 1));
    } catch (e) {
      state = SplashStatus.error;
    }
  }

  Future<void> _checkSession() async {
    final uid = _cacheRepo.getString(SharedPrefsKeys.isUserLoggedIn);

    if (uid != null && uid.isNotEmpty) {
      final response = await _userRepo.getUser(uid);

      if (response.success ?? false) {
        state = SplashStatus.authenticated;
      } else {
        state = SplashStatus.unauthenticated;
      }
    } else {
      state = SplashStatus.unauthenticated;
    }
  }
}
