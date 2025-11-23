part of '../chat_view.dart';

@immutable
final class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.onSuggestionSelected});

  final ValueChanged<String> onSuggestionSelected;

  @override
  Widget build(BuildContext context) {
    final suggestions = [
      StringConstants.suggestImage,
      StringConstants.suggestTTS,
      StringConstants.suggestPdf,
      StringConstants.suggestCredit,
      StringConstants.suggestAppInfo,
    ];

    return Center(
      child: SingleChildScrollView(
        padding: VPadding.all(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: VPadding.all(),
              decoration: const BoxDecoration(
                color: ColorName.primary,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.auto_awesome_rounded,
                size: 48,
                color: ColorName.backgroundLight,
              ),
            ),

            VSizedBox.verticalBox32,
            const VText(
              StringConstants.howCanIHelp,
              type: VTextStyleType.titleLarge,
              fontWeight: FontWeight.bold,
            ),
            VSizedBox.verticalBox32,
            Wrap(
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.center,
              children: suggestions.map((text) {
                return ActionChip(
                  label: VText(text),
                  avatar: const Icon(Icons.lightbulb_outline),
                  onPressed: () => onSuggestionSelected(text),
                  side: const BorderSide(
                    color: ColorName.secondary,
                  ),
                  shape: const StadiumBorder(),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
