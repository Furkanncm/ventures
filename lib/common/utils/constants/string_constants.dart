final class StringConstants {
  StringConstants._();

  static const String appName = 'Ventures';
  static const String imagePackage = 'codegen';
  static const String eventlabBaseUrl =
      'https://api.elevenlabs.io/v1/text-to-speech/';

  static final emailRegExp = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$",
  );
  static final passwordRegex = RegExp(r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$');

  static const String dateFormat = 'dd MMM yyyy - HH:mm';

  static const String registerFailed = 'Registration failed';
  static const String loginFailed = 'Login failed';
  static const String googleLoginSuccessful =
      'Successfully logged in with Google';
  static const String googleLoginCanceled = 'Google login cancelled';
  static const String logoutSuccessful = 'Logout successful';
  static const String currentUserFound = 'Current user found';
  static const String noUserLoggedIn = 'No user is currently logged in';
  static const String errorUserNotFound = 'User not found';

  // -----------------------------
  // Labels
  // -----------------------------
  static const String labelEmail = 'Email Address';
  static const String labelPassword = 'Password';
  static const String labelConfirmPassword = 'Confirm Password';

  static const String labelHaveAccount = 'Don’t have an account? ';

  /// Login Screen Labels
  static const String labelWelcomeBack = 'Welcome Back!';
  static const String labelLogin = 'Login';
  static const String labelLoginWithGoogle = 'Login with Google';
  static const String loginSuccess = 'Logged in successfully, welcome! 🎉';

  // SignUpView strings
  static const String labelCreateAccount = 'Create Account';
  static const String labelSignUp = 'Sign Up';
  static const String labelSignUpWithGoogle = 'Sign Up with Google';
  static const String labelDisplayName = 'Username';
  static const String errorConfirmPasswordEmpty =
      'Confirm password cannot be empty';
  static const String errorPasswordMismatch = 'Passwords do not match';

  static const String registerSuccess =
      'Congratulations, your registration is complete! 😎';

  // -----------------------------
  // Messages & Feedback
  // -----------------------------
  static const String messageSomethingWentWrong = 'Something went wrong 😅';

  // -----------------------------
  // Validations
  // -----------------------------
  static const String validationEmailRequired = 'Email field is required.';
  static const String validationEmailInvalid = 'Invalid email format.';
  static const String validationPasswordRequired =
      'Password field is required.';
  static const String validationPasswordMin =
      'Password must be at least 7 characters long.';
  static const String validationPasswordComplexity =
      'Password must contain uppercase, lowercase letters, and numbers.';
  static const String validationPasswordEquality = 'Passwords do not match.';
  static const String validationPhoneInvalid = 'Invalid phone number.';

  static const String userFetchedSuccessfully = 'User fetched successfully';
  static const String userUpdatedSuccessfully = 'User updated successfully';
  static const String historyItemAdded = 'History item added';
  static const String publicItemAdded = 'Public item added';
  static const String errorReported = 'Error reported';
  static const String publicItemsFetched = 'Public items fetched';
  static const String historyItemsFetched = 'History items fetched';

  // -----------------------------
  // Firebase Auth Errors
  // -----------------------------
  static const String errorInvalidEmail = 'Invalid email address.';
  static const String errorUserDisabled = 'User has been disabled.';
  static const String errorWrongPassword = 'Incorrect password.';
  static const String errorEmailAlreadyInUse = 'This email is already in use.';
  static const String errorOperationNotAllowed =
      'This operation is not allowed right now.';
  static const String errorWeakPassword = 'Password is too weak.';
  static const String errorUnknown = 'Unknown error';
  static const String errorGeneric = 'An error occurred';
  static const String errorInvalidCred = 'Incorrect username or password!';

  // -----------------------------
  // Profile Labels
  // -----------------------------
  static const String profileTitle = 'My Account';
  static const String profileNoName = 'No name available';
  static const String profileNoEmail = 'No email available';
  static const String profileSubscription = 'Subscription';
  static const String profileFreeUsage = 'Free Usage';
  static const String profilePublicItems = 'Shared Items';
  static const String profileHistoryItems = 'History Items';

  // ImageView
  static const String imageGeneratorTitle = 'Image Generator';
  static const String generateButtonLabel = 'Generate Image';
  static const String promptLabel = 'Enter your prompt...';
  static const String noImageMessage = 'No image generated yet.';
  static const String imageSuccessMessage = 'Image generated successfully!';
  static const String imageErrorMessage =
      'An error occurred while generating the image.';

  static const String sure = 'Are you sure?';
  static const String deleteContent =
      'Are you sure you want to permanently delete this image?';
  static const String imageHistoryTitle = 'Image History';
  static const String noSavedImages = 'No saved images available yet.';

  // Sharing
  static const String shareImageFail = 'Image could not be shared!';
  static const String shareImageSuccess = 'Image shared successfully!';
  static const String saveImageFail = 'Image could not be saved!';
  static const String shareAudioFail = 'Audio could not be shared!';
  static const String shareAudioSuccess = 'Audio shared successfully!';
  static const String saveAudioFail = 'Audio could not be saved!';
  
  static const String saveAudioSuccess = 'Audio save successfully!';

  // Text To Speech (TTS) Strings
  static const String ttsTitle = 'Text to Speech';
  static const String convertToSpeech = 'Convert to Speech';
  static const String play = 'Play';
  static const String fileSize = 'File Size';
  static const String audioDataNullError =
      'Audio data could not be retrieved (Null data).';
  static const String audioHistoryTitle = 'Audio History';
  static const String noAudioRecordedYet = 'No audio recorded yet.';
  static const String deleteDialogTitle = 'Delete Recording';
  static const String deleteDialogContent =
      'Are you sure you want to delete this audio? This action cannot be undone.';
  static const String downloadSuccess = 'Saved to Downloads!';
  static const String downloadFail = 'Download failed!';
}
