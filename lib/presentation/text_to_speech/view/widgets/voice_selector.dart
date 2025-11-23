part of '../text_to_speech_view.dart';

@immutable
final class _VoiceSelector extends ConsumerWidget {
  const _VoiceSelector();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(ttsProvider);
    final notifier = ref.read(ttsProvider.notifier);

    if (state.voices.isEmpty) return VSizedBox.emptyBox;

    final selectedVoice = state.selectedVoice ?? state.voices.first;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const VFaddedText(
          text: StringConstants.selectVoice,
          textStyleType: VTextStyleType.titleSmall,
        ),
        VSizedBox.verticalBox8,

        InkWell(
          onTap: () async {
            await VBottomSheets.showVoiceSelectionSheet(
              context: context,
              voices: state.voices,
              selectedVoice: selectedVoice,
              onVoiceSelected: notifier.selectVoice,
            );
          },
          borderRadius: BorderRadius.circular(16),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: Theme.of(context).cardColor,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: ColorName.gray.withValues(alpha: 0.2),
              ),
            ),
            child: Row(
              children: [
                VoiceIcon(voice: selectedVoice),

                VSizedBox.horizontalBox12,

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      VText(selectedVoice.name, fontWeight: FontWeight.bold),
                      VSizedBox.verticalBox4,
                      VText(
                        '${selectedVoice.accentEnum.displayName} • ${selectedVoice.gender.name.toUpperCase()}',
                        type: VTextStyleType.bodySmall,
                        color: ColorName.gray,
                      ),
                    ],
                  ),
                ),

                const Icon(
                  Icons.keyboard_arrow_down_rounded,
                  color: ColorName.gray,
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
