part of '../profile_view.dart';

@immutable
final class _UsageStatistics extends StatelessWidget {
  const _UsageStatistics({required this.user});

  final UserInfoModel user;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const VText(
          StringConstants.usageStatistics,
          type: VTextStyleType.titleMedium,
          fontWeight: FontWeight.bold,
        ),
        VSizedBox.verticalBox16,

        // 1. Resim Üretme Kotası
        _UsageBar(
          label: StringConstants.imageGeneration,
          current: user.imageGenUsage,
          max: user.maxFreeLimitPerFeature,
          color: ColorName.primary,
        ),
        VSizedBox.verticalBox12,

        // 2. TTS Kotası
        _UsageBar(
          label: StringConstants.textToSpeech,
          current: user.ttsUsage,
          max: user.maxFreeLimitPerFeature,
          color: ColorName.onSuccess,
        ),
        VSizedBox.verticalBox12,

        // 3. Doküman Analiz Kotası
        _UsageBar(
          label: StringConstants.documentAnalysis,
          current: user.docAnalysisUsage,
          max: user.maxFreeLimitPerFeature,
          color: ColorName.onError,
        ),
      ],
    );
  }
}

class _UsageBar extends StatelessWidget {
  const _UsageBar({
    required this.label,
    required this.current,
    required this.max,
    required this.color,
  });

  final String label;
  final int current;
  final int max;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final progress = (max > 0) ? (current / max) : 0.0;
    final remaining = max - current;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            VText(label),
            VText(
              '$current / $max ${StringConstants.used}',
              type: VTextStyleType.bodySmall,
              color: ColorName.gray,
            ),
          ],
        ),
        VSizedBox.horizontalBox8,
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress > 1 ? 1 : progress,
            minHeight: 8,
            backgroundColor: Colors.grey.shade200,
            color: remaining == 0 ? ColorName.onError : color,
          ),
        ),
      ],
    );
  }
}
