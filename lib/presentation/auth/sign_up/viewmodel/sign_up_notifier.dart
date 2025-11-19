import 'package:flutter_riverpod/legacy.dart';
import 'package:ventures/domain/auth/auth_repository.dart';
import 'package:ventures/presentation/auth/sign_up/viewmodel/sign_up_state.dart';

class SignUpNotifier extends StateNotifier<SignUpState> {
  SignUpNotifier(this._authRepository) : super(const SignUpState());

  final IAuthRepository _authRepository;

  /// Email / Password ile kayıt
  Future<void> register(
    String email,
    String password,
    String displayName,
  ) async {
    state = state.copyWith(isLoading: true);

    final response = await _authRepository.registerWithEmail(
      email: email,
      password: password,
      displayName: displayName,
    );

    if (response.success ?? false) {
      state = state.copyWith(isLoading: false, user: response.data);
    } else {
      state = state.copyWith(
        isLoading: false,
        error: response.message ?? 'Kayıt başarısız',
      );
    }
  }

  /// Google ile kayıt
  Future<void> registerWithGoogle() async {
    state = state.copyWith(isLoading: true);

    final response = await _authRepository.loginWithGoogle();

    if (response.success ?? false) {
      state = state.copyWith(isLoading: false, user: response.data);
    } else {
      state = state.copyWith(
        isLoading: false,
        error: response.message ?? 'Google ile kayıt başarısız',
      );
    }
  }
}
