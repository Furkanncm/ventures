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
        // Premium ise Altın rengi, değilse gri/beyaz
        color: isPremium ? Colors.amber.shade100 : Colors.grey.shade100,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isPremium ? Colors.amber : Colors.grey.shade300,
          width: 2,
        ),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Icon(
                isPremium ? Icons.verified : Icons.stars_rounded,
                color: isPremium ? Colors.orange : Colors.grey,
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
                      color: isPremium ? Colors.brown : Colors.black,
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
          
          // Eğer Free ise "Yükselt" butonu göster
          if (!isPremium) ...[
            VSizedBox.verticalBox16,
            VElevatedButton(
              onPressed: onUpgradeTap,
              label: StringConstants.upgradeToPremium,
              backgroundColor: Colors.black,
            ),
          ]
        ],
      ),
    );
  }
}