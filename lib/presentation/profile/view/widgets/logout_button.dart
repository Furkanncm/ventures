part of '../profile_view.dart';

@immutable
final class _LogoutButton extends ConsumerWidget {
  const _LogoutButton();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SizedBox(
      width: double.infinity,
      child: OutlinedButton.icon(
        onPressed: () async {
          final _ = await VDialogs.logOutDialog(
            context: context,
            onPositiveButton: () async =>
                ref.read(profileNotifierProvider.notifier).logout(),
          );
        },
        icon: const Icon(Icons.logout, color: ColorName.onError),
        label: const VText(
          StringConstants.logout,
          color: ColorName.onError,
        ),
        style: OutlinedButton.styleFrom(
          padding: VPadding.verticalMediumPadding(),
          side: const BorderSide(color: ColorName.onError),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
