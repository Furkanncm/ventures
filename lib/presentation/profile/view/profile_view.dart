import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/v_value.dart';
import 'package:ventures/common/utils/padding/v_padding.dart';
import 'package:ventures/common/widgets/sized_box/v_sized_box.dart';
import 'package:ventures/common/widgets/text/v_text.dart';
import 'package:ventures/data/model/user/user_info.dart';
import 'package:ventures/presentation/profile/viewmodel/profile_state.dart';

part 'widgets/profile_header.dart';
part 'widgets/profile_items_list.dart';

@immutable
final class ProfileView extends ConsumerWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileNotifierProvider);
    final notifier = ref.read(profileNotifierProvider.notifier);

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (state.user == null && !state.isLoading) {
        notifier.fetchUser();
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const VText(
          StringConstants.profileTitle,
          type: VTextStyleType.titleLarge,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              await ref.read(profileNotifierProvider.notifier).logout();
            },
          ),
        ],
      ),
      body: state.isLoading
          ? const Center(child: CircularProgressIndicator())
          : state.error != null
          ? Center(child: VText(state.error!))
          : state.user == null
          ? const Center(
              child: VText(StringConstants.errorUserNotFound),
            )
          : _Body(state: state),
    );
  }
}

@immutable
final class _Body extends StatelessWidget {
  const _Body({
    required this.state,
  });

  final ProfileState state;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: VPadding.all(),
      child: Column(
        spacing: VValue.large.value,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// PROFILE HEADER
          _ProfileHeader(user: state.user!),

          /// PUBLIC ITEMS
          _ProfileItemsList(
            title: StringConstants.profilePublicItems,
            items: state.publicItems,
            icon: Icons.public,
          ),

          /// HISTORY ITEMS
          _ProfileItemsList(
            title: StringConstants.profileHistoryItems,
            items: state.historyItems,
            icon: Icons.history,
          ),
        ],
      ),
    );
  }
}
