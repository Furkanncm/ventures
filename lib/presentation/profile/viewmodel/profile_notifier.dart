import 'package:flutter_riverpod/legacy.dart';
import 'package:ventures/common/router/router.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/dialog/v_dialog.dart';
import 'package:ventures/common/utils/enum/pref_keys.dart';
import 'package:ventures/common/utils/enum/route_path.dart';
import 'package:ventures/data/model/user/user_info.dart';
import 'package:ventures/domain/auth/auth_repository.dart';
import 'package:ventures/domain/cache/cache_repository.dart';
import 'package:ventures/domain/user/user_repository.dart';
import 'package:ventures/presentation/profile/viewmodel/profile_state.dart';

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier(this._repository, this._cache, this.authRepository)
    : super(const ProfileState());
  final IUserRepository _repository;
  final ICacheRepository _cache;
  final IAuthRepository authRepository;

  String? get uid => _cache.getString(PrefKeys.isUserLoggedIn);

  /// Logout
  Future<void> logout() async {
    state = state.copyWith(isLoading: true);

    final response = await authRepository.logout();

    if (response.success ?? false) {
      state = state.copyWith(
        isLoading: false,
      );

      router.goNamed(RoutePaths.login.name);
    } else {
      state = state.copyWith(
        isLoading: false,
        error: response.message ?? StringConstants.loginFailed,
      );
    }
  }

  Future<void> fetchUser() async {
    final userId = uid;
    if (userId == null) {
      state = state.copyWith(error: StringConstants.noUserLoggedIn);
      return;
    }

    state = state.copyWith(isLoading: true);
    final response = await _repository.getUser(userId);
    if (response.success ?? false) {
      state = state.copyWith(user: response.data, isLoading: false);
      await fetchHistoryItems();
      await fetchPublicItems();
    } else {
      state = state.copyWith(isLoading: false, error: response.message);
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

  Future<void> fetchHistoryItems() async {
    final userId = uid;
    if (userId == null) return;

    final response = await _repository.getHistoryItems(userId);
    if (response.success ?? false) {
      state = state.copyWith(historyItems: response.data ?? []);
    }
  }

  Future<void> fetchPublicItems() async {
    final userId = uid;
    if (userId == null) return;

    final response = await _repository.getPublicItems(userId);
    if (response.success ?? false) {
      state = state.copyWith(publicItems: response.data ?? []);
    }
  }

  Future<void> addHistory(String itemId) async {
    final userId = uid;
    if (userId == null) return;

    await _repository.addHistoryItem(userId, itemId);
    await fetchHistoryItems();
  }

  Future<void> addPublicItem(String itemId) async {
    final userId = uid;
    if (userId == null) return;

    await _repository.addPublicItem(userId, itemId);
    await fetchPublicItems();
  }

  Future<void> reportError(String error) async {
    final userId = uid;
    if (userId == null) return;

    await _repository.reportError(userId, error);
  }
}
