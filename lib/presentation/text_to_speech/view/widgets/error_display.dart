part of '../text_to_speech_view.dart';

@immutable
final class _TTSErrorDisplay extends StatelessWidget {
  const _TTSErrorDisplay({required this.errorMessage});

  final String errorMessage;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: VPadding.all() / 2,
      decoration: CustomBoxDecoration.errorContainer(),
      child: VText(
        '${StringConstants.errorUnknown}: $errorMessage',
        color: ColorName.onError,
      ),
    );
  }
}
