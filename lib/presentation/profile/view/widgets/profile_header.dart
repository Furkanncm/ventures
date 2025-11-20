part of '../profile_view.dart';

@immutable
final class _ProfileHeader extends StatelessWidget {
  const _ProfileHeader({required this.user});

  final UserInfoModel user;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Avatar
        CircleAvatar(
          radius: 40,
          backgroundImage: user.photoUrl != null
              ? NetworkImage(user.photoUrl!)
              : null,
          backgroundColor: ColorName.primary.withOpacity(0.2),
          child: user.photoUrl == null
              ? Text(
                  (user.displayName ?? 'U')[0].toUpperCase(),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                )
              : null,
        ),
        VSizedBox.horizontalBox16,
        // İsim ve Email
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VText(
                user.displayName ?? 'User',
                type: VTextStyleType.titleMedium,
                fontWeight: FontWeight.bold,
              ),
              VSizedBox.verticalBox4,
              VText(
                user.email ?? '',
                color: Colors.grey,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
