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
import 'package:ventures/common/utils/padding/v_padding.dart';
import 'package:ventures/common/utils/snackbar/v_snackbar.dart';
import 'package:ventures/common/widgets/button/v_elevated_button.dart';
import 'package:ventures/common/widgets/sized_box/v_sized_box.dart';
import 'package:ventures/common/widgets/text/v_header_text.dart';
import 'package:ventures/common/widgets/text/v_text.dart';
import 'package:ventures/common/widgets/textfied/v_textfield.dart';
import 'package:ventures/presentation/auth/login/viewmodel/login_state.dart';

part 'mixin/login_mixin.dart';
part 'widgets/login_buttons.dart';
part 'widgets/login_footer.dart';
part 'widgets/login_form.dart';
part 'widgets/login_header.dart';

@immutable
final class LoginView extends ConsumerStatefulWidget {
  const LoginView({super.key});

  @override
  ConsumerState<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends ConsumerState<LoginView> with LoginListenerMixin {
  @override
  Widget build(BuildContext context) {
    useLoginListener();
    return Scaffold(
      body: Stack(
        children: [
          Container(decoration: const CustomBoxDecoration.lineerGradient()),
          Center(
            child: SingleChildScrollView(
              child: Card(
                margin: VPadding.horizontalMediumPadding(),
                elevation: 12,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                child: Padding(
                  padding: VPadding.all() * 2,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const LoginHeader(),
                      LoginForm(
                        formKey: formKey,
                        emailController: emailController,
                        passwordController: passwordController,
                      ),
                      VSizedBox.verticalBox24,
                      LoginButtons(
                        onEmailLoginPressed: login,
                        onGoogleLoginPressed: loginWithGoogle,
                      ),
                      const LoginFooter(),
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
