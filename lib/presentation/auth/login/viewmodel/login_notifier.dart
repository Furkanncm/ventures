import 'package:flutter_riverpod/legacy.dart';
import 'package:ventures/domain/auth/auth_repository.dart';
import 'package:ventures/presentation/auth/login/viewmodel/login_state.dart';

class LoginNotifier extends StateNotifier<LoginState> {
  LoginNotifier(this._authRepository) : super(const LoginState());
  final IAuthRepository _authRepository;

  /// Email/Password ile login
  Future<void> login(String email, String password) async {
    state = state.copyWith(isLoading: true);

    final response = await _authRepository.loginWithEmail(
      email: email,
      password: password,
    );

    if (response.success ?? false) {
      state = state.copyWith(isLoading: false, user: response.data);
    } else {
      state = state.copyWith(
        isLoading: false,
        error: response.message ?? 'Login failed',
      );
    }
  }

  /// Google login
  Future<void> loginWithGoogle() async {
    state = state.copyWith(isLoading: true);

    final response = await _authRepository.loginWithGoogle();

    if (response.success ?? false) {
      state = state.copyWith(isLoading: false, user: response.data);
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
