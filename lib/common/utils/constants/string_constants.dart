final class StringConstants {
  StringConstants._();

  // -----------------------------
  // Regex Patterns (Validasyon İçin)
  // -----------------------------
  static final RegExp emailRegExp = RegExp(
    r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+\.[a-zA-Z]{2,}$",
  );
  static final RegExp passwordRegex = RegExp(
    r'^(?=.*[a-z])(?=.*[A-Z])(?=.*\d).+$',
  );

  // -----------------------------
  // App General
  // -----------------------------
  static const String appName = 'Ventures';
  static const String appNameAllCaps = 'VENTURES AI';
  static const String appSlogan = 'Your Intelligent Companion';
  static const String initializingAi = 'INITIALIZING AI...';
  static const String imagePackage = 'codegen';
  static const String dateFormat = 'dd MMM yyyy - HH:mm';
  static const String defaultVoice = '21m00Tcm4TlvDq8ikWAM';

  // -----------------------------
  // Auth (Login & Register)
  // -----------------------------
  static const String labelEmail = 'Email Address';
  static const String labelPassword = 'Password';
  static const String labelConfirmPassword = 'Confirm Password';
  static const String labelHaveAccount = 'Don’t have an account? ';
  static const String labelWelcomeBack = 'Welcome Back!';
  static const String labelLogin = 'Login';
  static const String labelLoginWithGoogle = 'Login with Google';
  static const String loginSuccess = 'Logged in successfully, welcome! 🎉';
  static const String loginFailed = 'Login failed';

  static const String labelCreateAccount = 'Create Account';
  static const String labelSignUp = 'Sign Up';
  static const String labelSignUpWithGoogle = 'Sign Up with Google';
  static const String labelDisplayName = 'Username';
  static const String registerSuccess =
      'Congratulations, your registration is complete! 😎';
  static const String registerFailed = 'Registration failed';

  static const String googleLoginSuccessful =
      'Successfully logged in with Google';
  static const String googleLoginCanceled = 'Google login cancelled';
  static const String logoutSuccessful = 'Logout successful';

  static const String currentUserFound = 'Current user found';
  static const String noUserLoggedIn = 'No user is currently logged in';
  static const String errorUserNotFound = 'User not found';
  static const String errorInvalidCred = 'Incorrect username or password!';

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
  static const String errorConfirmPasswordEmpty =
      'Confirm password cannot be empty';
  static const String errorPasswordMismatch = 'Passwords do not match';

  // -----------------------------
  // Profile
  // -----------------------------
  static const String profileTitle = 'Profile';
  static const String subscriptionStatus = 'Subscription Status';
  static const String freePlan = 'Free Plan';
  static const String premiumPlan = 'Premium Plan';
  static const String upgradeToPremium = 'Upgrade to Premium';
  static const String unlimitedAccess =
      'Get unlimited access to all AI features.';
  static const String usageStatistics = 'Usage Statistics';
  static const String remainingCredits = 'Remaining Credits';
  static const String used = 'Used';
  static const String logout = 'Logout';

  // -----------------------------
  // Features Titles
  // -----------------------------
  static const String imageGeneratorTitle = 'Image Generator';
  static const String ttsTitle = 'Text to Speech';
  static const String docAnalysisTitle = 'Document Analysis';

  // Feature Names (Usage Stats)
  static const String imageGeneration = 'Image Generation';
  static const String textToSpeech = 'Text to Speech';
  static const String documentAnalysis = 'Document Analysis';
  static const String defaultDocAnalysisPrompt =
      'Analyze this document and extract key information in detail.';

  // -----------------------------
  // Image Generation
  // -----------------------------
  static const String generateButtonLabel = 'Generate Image';
  static const String promptLabel = 'Enter your prompt...';
  static const String noImageMessage = 'No image generated yet.';
  static const String imageSuccessMessage = 'Image generated successfully!';
  static const String imageErrorMessage =
      'An error occurred while generating the image.';
  static const String imageSelectStyle = 'Select Style';
  static const String noStyleImage = 'No Style';

  // -----------------------------
  // Document Analysis
  // -----------------------------
  static const String tapToSelectDoc = 'Tap to select Image or PDF';
  static const String pdfSelected = 'PDF Document Selected';
  static const String askSomethingOptional =
      'Ask something specific (Optional)...';
  static const String analyzeDocument = 'Analyze Document';
  static const String analysisResult = 'Analysis Result:';
  static const String selectDocumentWarning =
      'Please select a document or image first.';
  static const String analysisReportTitle = 'Document Analysis Report';
  static const String analysisResultsHeader = 'Analysis Results';
  static const String analysisDetailsTitle = 'Analysis Details';
  static const String pdfDocument = 'PDF Document';
  static const String noPreviewAvailable = 'No Preview Available';
  static const String disclaimer =
      'Note: This content is generated by AI and may contain inaccuracies. Please verify important information.';

  // PDF Report
  static const String datePrefix = 'Date:';
  static const String generatedBy = 'Generated by Ventures AI';
  static const String aiGeneratedTag = 'AI GENERATED';
  static const String venturesBrand = 'VENTURES AI';
  static const String dateGenerated = 'DATE GENERATED';
  static const String type = 'TYPE';
  static const String poweredBy = 'Powered by Ventures App';
  static const String page = 'Page';
  static const String of = 'of';

  // -----------------------------
  // Text To Speech (TTS)
  // -----------------------------
  static const String convertToSpeech = 'Convert to Speech';
  static const String play = 'Play';
  static const String fileSize = 'File Size';
  static const String selectVoice = 'Select Voice';
  static const String audioDataNullError =
      'Audio data could not be retrieved (Null data).';

  // -----------------------------
  // History
  // -----------------------------
  static const String imageHistoryTitle = 'Image History';
  static const String audioHistoryTitle = 'Text To Speech History';
  static const String analysisHistoryTitle = 'Document Analysis History';

  static const String noSavedImages = 'No saved images available yet.';
  static const String noAudioRecordedYet = 'No audio recorded yet.';
  static const String noImageHistory = 'No generated images found.';
  static const String noAudioHistory = 'No voice recordings found.';
  static const String noDocumentHistory = 'No analysis history found.';
  static const String untitledDocument = 'Untitled Document';

  static const String userFetchedSuccessfully = 'User fetched successfully';
  static const String userUpdatedSuccessfully = 'User updated successfully';
  static const String historyItemAdded = 'History item added';
  static const String publicItemAdded = 'Public item added';
  static const String publicItemsFetched = 'Public items fetched';
  static const String historyItemsFetched = 'History items fetched';

  // -----------------------------
  // Dialogs & Bottom Sheets
  // -----------------------------
  static const String selectSource = 'Select Source';
  static const String takePhoto = 'Take Photo';
  static const String chooseFromGallery = 'Choose Image from Gallery';
  static const String choosePdf = 'Choose PDF Document';
  static const String close = 'Close';
  static const String cancel = 'Cancel';
  static const String exit = 'Exit';
  static const String delete = 'Delete';
  static const String download = 'Download';
  static const String share = 'Share';
  static const String clearTooltip = 'Clear';

  static const String exitAppTitle = 'Exit App';
  static const String exitAppContent =
      'Do you really want to close the application?';

  static const String logoutDialogTitle = 'Logging Out';
  static const String logoutDialogContent = 'Are you sure you want to leave?';

  static const String deleteDialogTitle = 'Delete Recording';
  static const String deleteDialogContent =
      'Are you sure you want to delete this audio? This action cannot be undone.';
  static const String deleteAnalysisTitle = 'Delete Analysis';
  static const String deleteAnalysisContent =
      'Are you sure you want to delete this item?';
  static const String deleteContent =
      'Are you sure you want to permanently delete this image?';
  static const String sure = 'Are you sure?';

  // -----------------------------
  // Sharing & Saving
  // -----------------------------
  static const String shareImageFail = 'Image could not be shared!';
  static const String shareImageSuccess = 'Image shared successfully!';
  static const String saveImageFail = 'Image could not be saved!';
  static const String shareAudioFail = 'Audio could not be shared!';
  static const String shareAudioSuccess = 'Audio shared successfully!';
  static const String saveAudioFail = 'Audio could not be saved!';
  static const String saveAudioSuccess = 'Audio saved successfully!';
  static const String downloadSuccess = 'Saved to Downloads!';
  static const String downloadFail = 'Download failed!';
  static const String pdfDownloadSuccess = 'PDF downloaded successfully!';
  static const String pdfDownloadFail = 'Download failed.';
  static const String shareAsPdf = 'Share as PDF';
  static const String shareError = 'Error while sharing:';
  static const String pdfCreationError = 'Error creating PDF:';

  // -----------------------------
  // Chat & AI
  // -----------------------------
  static const String chatTitle = 'Ventures Assistant 🤖';
  static const String chatInputHint = 'Ask a question...';
  static const String aiApiKeyNotFound = 'API Key not found';
  static const String apiKeyNotFound =
      'API Key not found. Please check your .env file.';
  static const String aiErrorPrefix = 'AI could not respond:';
  static const String aiUnknownResponse = 'Could not understand.';
  static const String online = 'Online';
  static const String aiTyping = 'AI is thinking...';
  static const String howCanIHelp = 'How can I help you today?';
  static const String clearChat = 'Clear Chat';
  static const String thinking = 'Thinking...';
  static const String aiSafetyError =
      'AI request blocked due to safety reasons:';
  static const String apiEmptyResponse = 'API returned an empty response.';
  static const String apiError = 'API Error:';
  static const String unknownConnectionError = 'Unknown connection error.';
  static const String connectionErrorPrefix = 'Connection Error';
  static const String unknownError = 'Unknown Error:';

  // -----------------------------
  // Voice Accents
  // -----------------------------
  static const String accentAmerican = 'American';
  static const String accentBritish = 'British';
  static const String accentAustralian = 'Australian';
  static const String accentIndian = 'Indian';
  static const String accentAfrican = 'African';
  static const String accentGeneral = 'General';

  // -----------------------------
  // Errors & Common
  // -----------------------------
  static const String messageSomethingWentWrong = 'Something went wrong 😅';
  static const String freeLimitReached =
      'Free usage limit reached. Please upgrade to Premium.';
  static const String errorReported = 'Error reported';
  static const String errorGeneric = 'An error occurred';
  static const String errorInvalidEmail = 'Invalid email address.';
  static const String errorUserDisabled = 'User has been disabled.';
  static const String errorWrongPassword = 'Incorrect password.';
  static const String errorEmailAlreadyInUse = 'This email is already in use.';
  static const String errorOperationNotAllowed =
      'This operation is not allowed right now.';
  static const String errorWeakPassword = 'Password is too weak.';
  static const String errorUnknown = 'Unknown error';

  // Chat Suggestions
  static const String suggestTTS = 'How to convert text to speech? 🗣️';
  static const String suggestImage = 'How to create an image? 🎨';
  static const String suggestPdf = 'Can you analyze a PDF? 📄';
  static const String suggestCredit = 'How much credit do I have? 💎';
  static const String suggestAppInfo = 'Tell me about this app 🚀';

  static const String aiSystemInstruction = '''
You are the AI Assistant for the "Ventures" mobile application.
Your Goal: Answer user questions about the app and guide them.

App Features:
1. Document Analysis: Users can upload images or PDFs to be analyzed by AI.
2. Text to Speech (TTS): Converts text to speech, downloadable as MP3.
3. Image Generation: Generates images from text prompts.
4. History: All transactions (Docs, Audio, Images) are saved in history.
5. Credit System: Free users have 3 credits per feature. Premium is unlimited.

Rules:
- NEVER answer general questions like history, math, coding, or weather.
- If asked about non-app topics, reply: "I can only assist with the Ventures app."
- Keep answers concise, polite, and use emojis.
''';
}
