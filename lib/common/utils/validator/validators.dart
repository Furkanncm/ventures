import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/extensions/string_extension.dart';

abstract class Validators {
  Validators._();

  static String? emailValidator(String? value) {
    if (value.isNullOrEmpty) {
      return StringConstants.validationEmailRequired;
    }
    if (!StringConstants.emailRegExp.hasMatch(value!)) {
      return StringConstants.validationEmailInvalid;
    }
    return null;
  }

  static String? passwordValidator(String? value) {
    final response = _checkPassword(value);
    if (response != null) return response;
    return null;
  }

  static String? confirmPasswordValidator(String? value, String password) {
    final response = _checkPassword(value);
    if (response != null) return response;
    if (value != password) {
      return StringConstants.validationPasswordEquality;
    }
    return null;
  }

  static String? _checkPassword(String? value) {
    if (value.isNullOrEmpty) {
      return StringConstants.validationPasswordRequired;
    }
    if (value!.length < 7) {
      return StringConstants.validationPasswordMin;
    }
    if (!StringConstants.passwordRegex.hasMatch(value)) {
      return StringConstants.validationPasswordComplexity;
    }
    return null;
  }


}
