import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:ventures/common/base/base_remote_response.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/auth_provider.dart';
import 'package:ventures/common/utils/enum/firebase_auth_enum.dart';
import 'package:ventures/common/utils/exceptions/firebase_exceptions.dart';
import 'package:ventures/data/model/user/user_auth.dart';

abstract class IAuthRemoteDS {
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

final class AuthRemoteDS implements IAuthRemoteDS {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    clientId: dotenv.env['WEB_CLIENT_ID'],
  );

  FirebaseAuthEnum authStatus = FirebaseAuthEnum.unauthenticated;

  /// ---------------------------
  /// Safe Call Helper
  /// ---------------------------
  Future<T?> safeCall<T>(Future<T> Function() action) async {
    try {
      return await action();
    } catch (e) {
      throw FirebaseAuthExceptionHandler.fromException(e);
    }
  }

  /// ---------------------------
  /// Email / Password Register
  /// ---------------------------
  @override
  Future<BaseRemoteResponse<AuthUser>> registerWithEmail({
    required String email,
    required String password,
    String? displayName,
  }) async {
    final user = await safeCall(() async {
      final result = await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (displayName != null) {
        await result.user?.updateDisplayName(displayName);
      }

      _setAuthStatus(result.user);
      return _mapFirebaseUser(result.user);
    });

    return BaseRemoteResponse(
      data: user,
      success: user != null,
      message: user != null
          ? StringConstants.registerSuccess
          : StringConstants.registerFailed,
      statusCode: user != null ? 200 : 400,
    );
  }

  /// ---------------------------
  /// Email / Password Login
  /// ---------------------------
  @override
  Future<BaseRemoteResponse<AuthUser>> loginWithEmail({
    required String email,
    required String password,
  }) async {
    final user = await safeCall<AuthUser>(() async {
      final result = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      _setAuthStatus(result.user);
      return _mapFirebaseUser(result.user);
    });

    return BaseRemoteResponse<AuthUser>(
      data: user,
      success: user != null,
      message: user != null
          ? StringConstants.loginSuccess
          : StringConstants.loginFailed,
      statusCode: user != null ? 200 : 400,
    );
  }

  /// ---------------------------
  /// Google Login
  /// ---------------------------
  @override
  Future<BaseRemoteResponse<AuthUser>> loginWithGoogle() async {
    final user = await safeCall<AuthUser?>(() async {
      await _googleSignIn.signOut();
      final googleUser = await _googleSignIn.signIn();
      if (googleUser == null) return null;

      final googleAuth = await googleUser.authentication;
      if (googleAuth.idToken != null && googleAuth.accessToken != null) {
        final credential = GoogleAuthProvider.credential(
          idToken: googleAuth.idToken,
          accessToken: googleAuth.accessToken,
        );

        final userCredential = await _auth.signInWithCredential(credential);
        _setAuthStatus(userCredential.user);

        if (userCredential.user != null) {
          return _mapFirebaseUser(
            userCredential.user,
            provider: AuthProviderEnum.google.value,
          );
        }
      }
      return null;
    });

    return BaseRemoteResponse(
      data: user,
      success: user != null,
      message: user != null
          ? StringConstants.googleLoginSuccessful
          : StringConstants.googleLoginCanceled,
      statusCode: user != null ? 200 : 400,
    );
  }

  /// ---------------------------
  /// LOGOUT
  /// ---------------------------
  @override
  Future<BaseRemoteResponse<void>> logout() async {
    await safeCall(() async {
      await _googleSignIn.signOut();
      await _auth.signOut();
      await _auth.currentUser?.reload();
      
      authStatus = FirebaseAuthEnum.unauthenticated;
    });

    return BaseRemoteResponse(
      data: null,
      success: true,
      message: StringConstants.logoutSuccessful,
      statusCode: 200,
    );
  }

  /// ---------------------------
  /// Current User
  /// ---------------------------
  @override
  BaseRemoteResponse<AuthUser> getCurrentUser() {
    final user = _auth.currentUser;
    return BaseRemoteResponse(
      data: user != null ? _mapFirebaseUser(user) : null,
      success: user != null,
      message: user != null
          ? StringConstants.currentUserFound
          : StringConstants.noUserLoggedIn,
      statusCode: user != null ? 200 : 404,
    );
  }

  /// ---------------------------
  /// Helpers
  /// ---------------------------
  void _setAuthStatus(User? user) {
    authStatus = user != null
        ? FirebaseAuthEnum.authenticated
        : FirebaseAuthEnum.unauthenticated;
  }

  AuthUser _mapFirebaseUser(User? user, {String? provider}) {
    if (user == null) {
      throw FirebaseAuthExceptionHandler(StringConstants.errorUserNotFound);
    }

    return AuthUser(
      uid: user.uid,
      email: user.email,
      displayName: user.displayName,
      photoUrl: user.photoURL,
      isEmailVerified: user.emailVerified,
      createdAt: user.metadata.creationTime ?? DateTime.now(),
      authProvider: provider ?? AuthProviderEnum.email.value,
    );
  }
}
