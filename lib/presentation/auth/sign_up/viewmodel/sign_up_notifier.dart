import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ventures/common/providers/repository_providers.dart'; // Import unutma
import 'package:ventures/common/router/router.dart';
import 'package:ventures/common/utils/enum/route_path.dart';
import 'package:ventures/domain/auth/auth_repository.dart';
import 'package:ventures/domain/user/user_repository.dart';
import 'package:ventures/presentation/auth/sign_up/viewmodel/sign_up_state.dart';

class SignUpNotifier extends StateNotifier<SignUpState> {
  // Constructor'a Ref ekledik
  SignUpNotifier(this._authRepository, this._userRepository, this.ref)
    : super(const SignUpState());

  final IAuthRepository _authRepository;
  final IUserRepository _userRepository;
  final Ref ref; // Ref

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

    if ((response.success ?? false) && response.data != null) {
      final uid = response.data!.uid!;
      await _userRepository.getUser(uid);

      // --- RESETLEME ---
      ref.invalidate(profileNotifierProvider);
      // -----------------

      state = state.copyWith(isLoading: false, user: response.data);
      router.goNamed(RoutePaths.Image.name);
    } else {
      state = state.copyWith(
        isLoading: false,
        error: response.message ?? 'Kayıt başarısız',
      );
    }
  }

  Future<void> registerWithGoogle() async {
    state = state.copyWith(isLoading: true);
    final response = await _authRepository.loginWithGoogle();

    if ((response.success ?? false) && response.data != null) {
      final uid = response.data!.uid!;
      await _userRepository.getUser(uid);

      // --- RESETLEME ---
      ref.invalidate(profileNotifierProvider);
      // -----------------

      state = state.copyWith(isLoading: false, user: response.data);
      router.goNamed(RoutePaths.Image.name);
    } else {
      state = state.copyWith(
        isLoading: false,
        error: response.message ?? 'Hata',
      );
    }
  }
}
