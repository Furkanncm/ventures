import 'package:codegen/gen/assets.gen.dart';
import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/common/router/router.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/decoration/box_decoration.dart';
import 'package:ventures/common/utils/enum/route_path.dart';
import 'package:ventures/common/utils/enum/snackbar_type.dart';
import 'package:ventures/common/utils/extensions/assets_extension.dart';
import 'package:ventures/common/utils/extensions/future_extension.dart';
import 'package:ventures/common/utils/snackbar/v_snackbar.dart';
import 'package:ventures/common/widgets/button/v_elevated_button.dart';
import 'package:ventures/common/widgets/sized_box/v_sized_box.dart';
import 'package:ventures/common/widgets/text/v_header_text.dart';
import 'package:ventures/common/widgets/text/v_text.dart';
import 'package:ventures/common/widgets/textfied/v_textfield.dart';
import 'package:ventures/presentation/auth/sign_up/viewmodel/sign_up_state.dart';

part 'mixin/sign_up_mixin.dart';
part 'widgets/sign_up_buttons.dart';
part 'widgets/sign_up_footer.dart';
part 'widgets/sign_up_form.dart';
part 'widgets/sign_up_header.dart';
@immutable
class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> with SignUpListenerMixin {
  @override
  Widget build(BuildContext context) {
    // Listener'ı çalıştır (Hata mesajları için)
    useSignUpListener(context, ref);
    
    // Loading durumunu izle (Butonlarda loading göstermek istersen)
    final state = ref.watch(signUpNotifierProvider);

    return Scaffold(
      body: Stack(
        children: [
          Container(decoration: const CustomBoxDecoration.lineerGradient()),
          Center(
            child: SingleChildScrollView(
              child: Card(
                margin: const EdgeInsets.symmetric(horizontal: 24),
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(32),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const SignUpHeader(),
                      SignUpForm(
                        formKey: formKey,
                        emailController: emailController,
                        passwordController: passwordController,
                        confirmPasswordController: confirmPasswordController,
                        displayNameController: displayNameController,
                      ),
                      VSizedBox.verticalBox24,
                      
                      // Butonlara loading state'ini de verebilirsin
                      state.isLoading 
                        ? const CircularProgressIndicator()
                        : SignUpButtons(
                            onEmailRegisterPressed: register, // Mixin'den geliyor
                            onGoogleRegisterPressed: registerWithGoogle, // Mixin'den geliyor
                          ),
                          
                      const SignUpFooter(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}