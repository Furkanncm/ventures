part of '../profile_view.dart';

@immutable
final class _SubscriptionCard extends StatelessWidget {
  const _SubscriptionCard({
    required this.user,
    required this.onUpgradeTap,
  });

  final UserInfoModel user;
  final VoidCallback onUpgradeTap;

  @override
  Widget build(BuildContext context) {
    final isPremium = user.subscriptionType == SubscriptionType.premium;

    return Container(
      padding: VPadding.all(),
      decoration: BoxDecoration(
        color: isPremium
            ? ColorName.primary.withValues(alpha: 0.1)
            : ColorName.gray.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPremium ? ColorName.primary : ColorName.gray,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                isPremium ? Icons.verified : Icons.stars_rounded,
                color: isPremium ? ColorName.primary : ColorName.gray,
                size: 32,
              ),
              VSizedBox.horizontalBox12,
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    VText(
                      isPremium
                          ? StringConstants.premiumPlan
                          : StringConstants.freePlan,
                      type: VTextStyleType.titleMedium,
                      fontWeight: FontWeight.w800,
                      color: isPremium
                          ? ColorName.primary
                          : ColorName.backgroundDark,
                    ),
                    if (!isPremium)
                      const VText(
                        StringConstants.unlimitedAccess,
                        type: VTextStyleType.bodySmall,
                      ),
                  ],
                ),
              ),
            ],
          ),
          if (!isPremium) ...[
            VSizedBox.verticalBox16,
            VElevatedButton(
              onPressed: onUpgradeTap,
              label: StringConstants.upgradeToPremium,
              backgroundColor: ColorName.backgroundDark,
            ),
          ],
        ],
      ),
    );
  }
}
