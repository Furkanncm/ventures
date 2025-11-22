import 'package:flutter_riverpod/legacy.dart';
import 'package:ventures/common/utils/enum/pref_keys.dart';
import 'package:ventures/domain/cache/cache_repository.dart';
import 'package:ventures/domain/user/user_repository.dart';

// Splash ekranının durumları
enum SplashStatus { loading, authenticated, unauthenticated, error }

class SplashNotifier extends StateNotifier<SplashStatus> {
  SplashNotifier(this._userRepo, this._cacheRepo)
    : super(SplashStatus.loading) {
    _checkSession();
  }

  final IUserRepository _userRepo;
  final ICacheRepository _cacheRepo;

  Future<void> _checkSession() async {
    // 1. Logo görünsün diye kısa bir bekleme (İsteğe bağlı, kaldırabilirsin)
    await Future<void>.delayed(const Duration(seconds: 1));

    // 2. Cache'den UID'yi al
    final uid = _cacheRepo.getString(PrefKeys.isUserLoggedIn);

    // 3. UID kontrolü
    if (uid != null && uid.isNotEmpty) {
      // UID var, Firebase'e git ve veriyi çek
      final response = await _userRepo.getUser(uid);

      if (response.success ?? false) {
        // Veri çekildi ve repo'ya setlendi -> İçeri al
        state = SplashStatus.authenticated;
      } else {
        state = SplashStatus.unauthenticated;
      }
    } else {
      // UID yok -> Login'e at
      state = SplashStatus.unauthenticated;
    }
  }
}
