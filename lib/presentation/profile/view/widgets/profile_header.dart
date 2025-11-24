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
          backgroundColor: ColorName.primary,
          child: user.photoUrl != null
              ? null
              : const Icon(
                  Icons.account_circle_outlined,
                  size: 64,
                ),
        ),
        VSizedBox.horizontalBox16,
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              VText(
                user.displayName.isNotNullOrNotEmpty
                    ? user.displayName!
                    : 'Guest User',
                type: VTextStyleType.titleMedium,
                fontWeight: FontWeight.bold,
              ),
              VSizedBox.verticalBox4,
              VFaddedText(text: user.email ?? ''),
            ],
          ),
        ),
      ],
    );
  }
}
