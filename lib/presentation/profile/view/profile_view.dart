import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/subscription_type.dart';
import 'package:ventures/common/utils/padding/v_padding.dart';
import 'package:ventures/common/widgets/button/v_elevated_button.dart';
import 'package:ventures/common/widgets/sized_box/v_sized_box.dart';
import 'package:ventures/common/widgets/text/v_text.dart';
import 'package:ventures/data/model/user/user_info.dart';
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
      appBar: AppBar(
        title: const VText(
          StringConstants.profileTitle,
          type: VTextStyleType.titleLarge,
        ),
      ),
      body: RefreshIndicator(
        // Aşağı çekince verileri yenile
        onRefresh: () async => notifier.getUser(),
        child: state.isLoading
            ? const Center(child: CircularProgressIndicator())
            : state.error != null
            ? Center(child: VText(state.error!))
            : state.user == null
            ? const Center(child: CircularProgressIndicator())
            : _Body(state: state, notifier: notifier),
      ),
    );
  }
}

@immutable
final class _Body extends StatelessWidget {
  const _Body({
    required this.state,
    required this.notifier, // Premium upgrade için gerekli
  });

  final ProfileState state;
  final dynamic notifier; // ProfileNotifier tipini verebilirsin

  @override
  Widget build(BuildContext context) {
    final user = state.user!;

    return SingleChildScrollView(
      physics: const AlwaysScrollableScrollPhysics(),
      padding: VPadding.all(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// 1. PROFİL BAŞLIĞI (Avatar + İsim)
          _ProfileHeader(user: user),

          VSizedBox.verticalBox24,

          _SubscriptionCard(
            user: user,
            onUpgradeTap: () async {
              // Notifier üzerinden upgrade işlemini tetikle
              await notifier.upgradeToPremium();

              if (context.mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Welcome to Premium Club! 🌟'),
                    backgroundColor: Colors.amber,
                  ),
                );
              }
            },
          ),

          VSizedBox.verticalBox24,

          /// 3. KULLANIM İSTATİSTİKLERİ (Progress Barlar)
          if (user.subscriptionType == SubscriptionType.free)
            _UsageStatistics(user: user),

          VSizedBox.verticalBox24,

          /// 4. ÇIKIŞ BUTONU
          const _LogoutButton(),

          // Alt kısımda boşluk bırakmak için
          VSizedBox.verticalBox48,
        ],
      ),
    );
  }
}
