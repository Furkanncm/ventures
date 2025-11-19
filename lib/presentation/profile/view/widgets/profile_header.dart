part of '../profile_view.dart';

@immutable
final class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.user});

  final UserInfoModel user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage: user.photoUrl != null
              ? NetworkImage(user.photoUrl!)
              : null,
          child: user.photoUrl == null
              ? const Icon(Icons.person, size: 40)
              : null,
        ),
        VSizedBox.horizontalBox16,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VText(
                user.displayName ?? StringConstants.profileNoName,
                type: VTextStyleType.titleLarge,
              ),
              VText(user.email ?? StringConstants.profileNoEmail),
              VSizedBox.verticalBox4,
              VText(
                '${StringConstants.profileSubscription}: ${user.subscriptionType.name}',
              ),
              VText(
                '${StringConstants.profileFreeUsage}: ${user.freeUsageCount}/${user.maxFreeUsage}',
              ),
            ],
          ),
        ),
      ],
    );
  }
}
