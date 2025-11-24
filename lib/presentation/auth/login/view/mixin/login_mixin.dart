part of '../login_view.dart';

mixin LoginListenerMixin on ConsumerState<LoginView> {
  late final GlobalKey<FormState> formKey;
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  void useLoginListener() {
    ref.listen<LoginState>(loginNotifierProvider, (prev, next) {
      if (next.user != null) {
        router.goNamed(RoutePaths.Image.name);
        next.copyWith();
      }
      if (next.error != null && next.error!.isNotEmpty) {
        VSnackBar.show(
          context: context,
          text: next.error!,
          type: SnackBarType.error,
        );
      }
    });
  }

  Future<void> login() async {
    if (!(formKey.currentState?.validate() ?? false)) return;
    final notifier = ref.read(loginNotifierProvider.notifier);
    await notifier
        .login(emailController.text, passwordController.text)
        .withLoading(context)
        .withSnackbar(context, successMessage: StringConstants.loginSuccess);
  }

  Future<void> loginWithGoogle() async {
    final notifier = ref.read(loginNotifierProvider.notifier);
    await notifier.loginWithGoogle().withLoading(context);
  }
}
