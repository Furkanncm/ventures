import 'package:flutter_riverpod/legacy.dart';
import 'package:ventures/common/router/router.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/feature_type.dart';
import 'package:ventures/common/utils/enum/route_path.dart';
import 'package:ventures/common/utils/enum/share_prefs_keys.dart';
import 'package:ventures/data/model/user/user_info.dart';
import 'package:ventures/domain/auth/auth_repository.dart';
import 'package:ventures/domain/shared_pref/share_pref_manager.dart';
import 'package:ventures/domain/user/user_repository.dart';
import 'package:ventures/presentation/profile/viewmodel/profile_state.dart';

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier(
    this._repository,
    this._cache,
    this.authRepository,
  ) : super(ProfileState.initial()) {
    _init();
  }

  final IUserRepository _repository;
  final SharedPrefsManager _cache;
  final IAuthRepository authRepository;

  String? get uid => _cache.getString(SharedPrefsKeys.isUserLoggedIn);

  void _init() {
    if (_repository.currentUser != null) {
      state = state.copyWith(
        user: _repository.currentUser,
        isLoading: false,
      );
    } else {
      getUser();
    }
  }

  Future<void> getUser() async {
    if (state.user == null) {
      state = state.copyWith(isLoading: true);
    }

    final userId = uid;
    if (userId == null) {
      state = state.copyWith(isLoading: false);
      return;
    }

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

  Future<void> updateUser(UserInfoModel user) async {
    state = state.copyWith(isLoading: true);
    final response = await _repository.setUser(user);

    if (response.success ?? false) {
      state = state.copyWith(user: user, isLoading: false);
    } else {
      state = state.copyWith(isLoading: false, error: response.message);
    }
  }

  Future<void> upgradeToPremium() async {
    final userId = uid;
    if (userId == null) return;

    state = state.copyWith(isLoading: true);

    await _repository.upgradeToPremium(userId);

    if (_repository.currentUser != null) {
      state = state.copyWith(user: _repository.currentUser, isLoading: false);
    } else {
      await getUser();
    }
  }

  Future<void> reportError(String error) async {
    final userId = uid;
    if (userId == null) return;
    await _repository.reportError(userId, error);
  }

  Future<void> logout() async {
    state = state.copyWith(isLoading: true);

    final response = await authRepository.logout();

    if (response.success ?? false) {
      router.goNamed(RoutePaths.login.name);
      await _cache.remove(SharedPrefsKeys.isUserLoggedIn);
      _repository.clearCurrentUser();

      state = ProfileState.initial();
    } else {
      state = state.copyWith(
        isLoading: false,
        error: response.message ?? StringConstants.errorUnknown,
      );
    }
  }

  Future<void> incrementLocalUsage(FeatureType type) async {
    final currentUser = _repository.currentUser ?? state.user;
    if (currentUser == null) return;

    UserInfoModel updatedUser;

    switch (type) {
      case FeatureType.imageGeneration:
        updatedUser = currentUser.copyWith(
          imageGenUsage: (currentUser.imageGenUsage) + 1,
        );
      case FeatureType.textToSpeech:
        updatedUser = currentUser.copyWith(
          ttsUsage: (currentUser.ttsUsage) + 1,
        );
      case FeatureType.documentAnalysis:
        updatedUser = currentUser.copyWith(
          docAnalysisUsage: (currentUser.docAnalysisUsage) + 1,
        );
    }

    _repository.setCurrentUser(updatedUser);
    state = state.copyWith(user: updatedUser);
    await _repository.incrementUsage(currentUser.uid!, type);
  }
}
