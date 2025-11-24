part of '../v_bottom_sheets.dart';

@immutable
final class _VoiceSelectionSheet extends StatelessWidget {
  const _VoiceSelectionSheet({
    required this.voices,
    required this.selectedVoice,
    required this.onVoiceSelected,
  });

  final List<VoiceModel> voices;
  final VoiceModel? selectedVoice;
  final ValueChanged<VoiceModel> onVoiceSelected;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const _SheetHeader(title: StringConstants.selectVoice),
        Flexible(
          child: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            shrinkWrap: true,
            itemCount: voices.length,
            separatorBuilder: (_, __) => Padding(
              padding: VPadding.verticalMediumPadding() / 4,
              child: const Divider(height: 1, indent: 60),
            ),
            itemBuilder: (context, index) {
              final voice = voices[index];
              final isSelected = voice == selectedVoice;

              return InkWell(
                onTap: () => onVoiceSelected(voice),
                borderRadius: BorderRadius.circular(12),
                child: Container(
                  padding: const VPadding.outlinedPadding(),
                  decoration: BoxDecoration(
                    color: isSelected
                        ? ColorName.primary.withValues(alpha: 0.05)
                        : null,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      VoiceIcon(voice: voice),

                      VSizedBox.horizontalBox12,

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              voice.name,
                              style: TextStyle(
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w500,
                                fontSize: 16,
                                color: isSelected ? ColorName.primary : null,
                              ),
                            ),
                            VSizedBox.verticalBox4,
                            Wrap(
                              spacing: 6,
                              children: [
                                if (voice.accentEnum.displayName.isNotEmpty)
                                  _TagText(text: voice.accentEnum.displayName),
                                if (voice.labels?.useCase != null)
                                  _TagText(text: voice.labels!.useCase!),
                              ],
                            ),
                          ],
                        ),
                      ),

                      if (isSelected)
                        const Icon(
                          Icons.check_circle_rounded,
                          color: ColorName.primary,
                        ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

@immutable
final class _TagText extends StatelessWidget {
  const _TagText({required this.text});
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: ColorName.gray.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        text.replaceAll('_', ' ').toUpperCase(),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.bold,
          color: ColorName.gray.withValues(alpha: 0.8),
        ),
      ),
    );
  }
}
