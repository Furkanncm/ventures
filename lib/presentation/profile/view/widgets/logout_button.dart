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
          // 1. Dialog'u göster ve cevabı bekle
          final shouldLogout = await VDialogs.logOutDialog(
            context: context,
            onPositiveButton: () async =>
                ref.read(profileNotifierProvider.notifier).logout(),
          );

          // 2. Eğer cevap 'true' ise (kullanıcı onay verdiyse) çıkış yap
          if (shouldLogout ?? false) {
            await ref.read(profileNotifierProvider.notifier).logout();
          }
        },
        icon: const Icon(Icons.logout, color: Colors.red),
        label: const VText(
          StringConstants.logout,
          color: Colors.red,
        ),
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          side: const BorderSide(color: Colors.red),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }
}
