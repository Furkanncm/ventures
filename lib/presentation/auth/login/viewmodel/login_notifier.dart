import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/common/router/router.dart';
import 'package:ventures/common/utils/enum/route_path.dart';
import 'package:ventures/domain/auth/auth_repository.dart';
import 'package:ventures/domain/user/user_repository.dart';
import 'package:ventures/presentation/auth/login/viewmodel/login_state.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier(this._authRepository, this._userRepository, this.ref)
    : super(const LoginState());

  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;
  final Ref ref; 

  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true);

    final response = await _authRepository.loginWithEmail(
      email: email,
      password: password,
    );

    if ((response.success ?? false) && response.data != null) {
      final uid = response.data!.uid!;

      await _userRepository.getUser(uid);

      ref.invalidate(profileNotifierProvider);

      state = state.copyWith(isLoading: false, user: response.data);
      router.goNamed(RoutePaths.Image.name);
    } else {
      state = state.copyWith(
        isLoading: false,
        error: response.message ?? 'Login failed',
      );
    }
  }

  Future<void> loginWithGoogle() async {
    state = state.copyWith(isLoading: true);
    final response = await _authRepository.loginWithGoogle();

    if ((response.success ?? false) && response.data != null) {
      final uid = response.data!.uid!;
      await _userRepository.getUser(uid);

      ref.invalidate(profileNotifierProvider);

      state = state.copyWith(isLoading: false, user: response.data);
      router.goNamed(RoutePaths.Image.name);
    } else {
      state = state.copyWith(
        isLoading: false,
        error: response.message ?? 'Google login failed',
      );
    }
  }

  void clearUser() {
    state = state.copyWith(isLoading: false);
  }
}
