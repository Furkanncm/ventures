import 'package:firebase_auth/firebase_auth.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';

class FirebaseAuthExceptionHandler implements Exception {
  FirebaseAuthExceptionHandler(this.message);

  /// Factory method: FirebaseException veya generic Exception’ı işler
  factory FirebaseAuthExceptionHandler.fromException(Object e) {
    if (e is FirebaseAuthException) {
      switch (e.code) {
        case 'invalid-email':
          return FirebaseAuthExceptionHandler(
            StringConstants.errorInvalidEmail,
          );
        case 'user-disabled':
          return FirebaseAuthExceptionHandler(
            StringConstants.errorUserDisabled,
          );
        case 'user-not-found':
          return FirebaseAuthExceptionHandler(
            StringConstants.errorUserNotFound,
          );
        case 'wrong-password':
          return FirebaseAuthExceptionHandler(
            StringConstants.errorWrongPassword,
          );
        case 'email-already-in-use':
          return FirebaseAuthExceptionHandler(
            StringConstants.errorEmailAlreadyInUse,
          );
        case 'operation-not-allowed':
          return FirebaseAuthExceptionHandler(
            StringConstants.errorOperationNotAllowed,
          );
        case 'weak-password':
          return FirebaseAuthExceptionHandler(
            StringConstants.errorWeakPassword,
          );
        case 'invalid-credential':
          return FirebaseAuthExceptionHandler(
            StringConstants.errorInvalidCred,
          );
        default:
          return FirebaseAuthExceptionHandler(
            '${StringConstants.errorUnknown}: ${e.message}',
          );
      }
    }

    return FirebaseAuthExceptionHandler(
      '${StringConstants.errorGeneric}: $e',
    );
  }

  final String message;

  @override
  String toString() => message;
}
