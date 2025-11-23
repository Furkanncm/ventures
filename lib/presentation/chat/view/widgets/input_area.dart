part of '../chat_view.dart';

@immutable
final class _InputArea extends StatelessWidget {
  const _InputArea({
    required this.controller,
    required this.isLoading,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool isLoading;
  final ValueChanged<String> onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: VPadding.pagePadding(),
      decoration: const BoxDecoration(
        color: ColorName.backgroundLight,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              textInputAction: TextInputAction.send,
              minLines: 1,
              maxLines: 4,
              decoration: const InputDecoration(
                hintText: StringConstants.chatInputHint,
              ),
              onSubmitted: (value) {
                if (!isLoading && value.trim().isNotEmpty) {
                  onSend(value);
                }
              },
            ),
          ),
          VSizedBox.horizontalBox12,
          IconButton.filled(
            onPressed: isLoading
                ? null
                : () {
                    if (controller.text.trim().isNotEmpty) {
                      onSend(controller.text);
                    }
                  },
            style: IconButton.styleFrom(
              backgroundColor: ColorName.primary,
              foregroundColor: ColorName.onPrimary,
            ),
            icon: isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      color: ColorName.onPrimary,
                    ),
                  )
                : const Icon(Icons.arrow_upward_rounded),
          ),
        ],
      ),
    );
  }
}
