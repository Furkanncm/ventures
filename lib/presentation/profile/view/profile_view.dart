import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventures/common/dialog/v_dialog.dart';
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/subscription_type.dart';
import 'package:ventures/common/utils/padding/v_padding.dart';
import 'package:ventures/common/widgets/appbar/v_app_bar.dart';
import 'package:ventures/common/widgets/button/v_elevated_button.dart';
import 'package:ventures/common/widgets/sized_box/v_sized_box.dart';
import 'package:ventures/common/widgets/text/v_text.dart';
import 'package:ventures/data/model/user/user_info.dart';
import 'package:ventures/presentation/profile/viewmodel/profile_notifier.dart';
import 'package:ventures/presentation/profile/viewmodel/profile_state.dart';

part 'widgets/logout_button.dart';
part 'widgets/profile_header.dart';
part 'widgets/subscription_card.dart';
part 'widgets/usage_statistics.dart';

@immutable
final class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileNotifierProvider);
    final notifier = ref.read(profileNotifierProvider.notifier);

    return Scaffold(
      appBar: const VAppbar(title: StringConstants.profileTitle),
      body: RefreshIndicator(
        onRefresh: () async => notifier.getUser(),
        child: Builder(
          builder: (context) {
            if (state.isLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            if (state.error != null) {
              return Center(child: VText(state.error!));
            }
            if (state.user == null) {
              return const Center(
                child: VText(StringConstants.errorUserNotFound),
              );
            }

            // 4. Her şey yolunda
            return _Body(state: state, notifier: notifier);
          },
        ),
      ),
    );
  }
}

@immutable
final class _Body extends StatelessWidget {
  const _Body({
    required this.state,
    required this.notifier,
  });

  final ProfileState state;
  final ProfileNotifier notifier;

  @override
  Widget build(BuildContext context) {
    final user = state.user!;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: VPadding.all(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProfileHeader(user: user),

          VSizedBox.verticalBox24,

          _SubscriptionCard(
            user: user,
            onUpgradeTap: () async {
              await notifier.upgradeToPremium();
            },
          ),

          VSizedBox.verticalBox24,

          if (user.subscriptionType == SubscriptionType.free)
            _UsageStatistics(user: user),

          VSizedBox.verticalBox24,

          const _LogoutButton(),

          VSizedBox.verticalBox48,
        ],
      ),
    );
  }
}
