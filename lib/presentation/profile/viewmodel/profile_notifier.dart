import 'package:flutter_riverpod/legacy.dart';
import 'package:ventures/common/router/router.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/pref_keys.dart';
import 'package:ventures/common/utils/enum/route_path.dart';
import 'package:ventures/data/model/user/user_info.dart';
import 'package:ventures/domain/auth/auth_repository.dart';
import 'package:ventures/domain/cache/cache_repository.dart';
import 'package:ventures/domain/user/user_repository.dart';
import 'package:ventures/presentation/profile/viewmodel/profile_state.dart';

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier(this._repository, this._cache, this.authRepository)
    : super(ProfileState.initial()) {
    getUser();
  }

  final IUserRepository _repository;
  final ICacheRepository _cache;
  final IAuthRepository authRepository;

  String? get uid => _cache.getString(PrefKeys.isUserLoggedIn);

  Future<void> getUser() async {
    final userId = uid;
    if (userId == null) return;

    final response = await _repository.getUser(userId);

    if (response.success ?? false) {
      state = state.copyWith(
        user: response.data,
        isLoading: false,
      );
    } else {
      state = state.copyWith(
        isLoading: false,
        error: response.message ?? StringConstants.errorUserNotFound,
      );
    }
  }

  /// Kullanıcıyı Güncelle
  Future<void> updateUser(UserInfoModel user) async {
    state = state.copyWith(isLoading: true);
    final response = await _repository.setUser(user);

    if (response.success ?? false) {
      state = state.copyWith(user: user, isLoading: false);
    } else {
      state = state.copyWith(isLoading: false, error: response.message);
    }
  }

  /// Premium'a Yükselt (Fake Payment Logic)
  Future<void> upgradeToPremium() async {
    final userId = uid;
    if (userId == null) return;

    state = state.copyWith(isLoading: true);

    // Repository üzerinden işlemi yap
    await _repository.upgradeToPremium(userId);

    // İşlem bitince kullanıcı verisini (ve abonelik tipini) tekrar çek
    await getUser();

    state = state.copyWith(isLoading: false);
  }

  /// Hata Raporla
  Future<void> reportError(String error) async {
    final userId = uid;
    if (userId == null) return;

    await _repository.reportError(userId, error);
  }

  /// Çıkış Yap
  Future<void> logout() async {
    state = state.copyWith(isLoading: true);

    final response = await authRepository.logout();

    if (response.success ?? false) {
      state = state.copyWith(isLoading: false);
      router.goNamed(RoutePaths.login.name);
    } else {
      state = state.copyWith(
        isLoading: false,
        error: response.message ?? StringConstants.errorUnknown,
      );
    }
  }
}
