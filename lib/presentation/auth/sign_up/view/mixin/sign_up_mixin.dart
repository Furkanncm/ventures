part of '../sign_up_view.dart';

mixin SignUpListenerMixin on ConsumerState<SignUpView> {
  late final GlobalKey<FormState> formKey;

  late final TextEditingController emailController;
  late final TextEditingController passwordController;
  late final TextEditingController confirmPasswordController;
  late final TextEditingController displayNameController;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
    confirmPasswordController = TextEditingController();
    displayNameController = TextEditingController();
  }

  void useSignUpListener(BuildContext context, WidgetRef ref) {
    ref.listen<SignUpState>(signUpNotifierProvider, (prev, next) {
      if (next.user != null) {
        router.goNamed(RoutePaths.Audio.name);
      }

      // Hata varsa Snackbar göster
      if (next.error != null && next.error!.isNotEmpty) {
        VSnackBar.show(
          context: context,
          text: next.error!,
          type: SnackBarType.error,
        );
      }
    });
  }

  Future<void> register() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    final notifier = ref.read(signUpNotifierProvider.notifier);
    await notifier
        .register(
          emailController.text,
          passwordController.text,
          displayNameController.text,
        )
        .withLoading(context)
        .withSnackbar(context, successMessage: StringConstants.registerSuccess);
  }

  Future<void> registerWithGoogle() async {
    final notifier = ref.read(signUpNotifierProvider.notifier);
    await notifier
        .registerWithGoogle()
        .withLoading(context)
        .withSnackbar(context, successMessage: StringConstants.registerSuccess);
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    displayNameController.dispose();
    super.dispose();
  }
}
