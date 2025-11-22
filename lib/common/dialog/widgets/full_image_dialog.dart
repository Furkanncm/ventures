part of '../v_dialog.dart';

@immutable
final class _FullImageDialog extends StatelessWidget {
  const _FullImageDialog({required this.file});

  final File file;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Colors.transparent,
      insetPadding: const VPadding.zeroPadding(),
      elevation: 0,
      child: Stack(
        fit: StackFit.expand,
        children: [
          Container(
            color: Colors.black.withValues(alpha: 0.9),
          ),
          GestureDetector(
            onTap: () => Navigator.of(context).pop(),
            behavior: HitTestBehavior.translucent,
            child: const SizedBox.expand(),
          ),

          Padding(
            padding: VPadding.pagePadding(),
            child: Center(
              child: InteractiveViewer(
                clipBehavior: Clip.none,
                minScale: 1,
                maxScale: 5,
                child: Hero(
                  tag: file.path,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),
                    child: Image.file(
                      file,
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
          ),

          Positioned(
            top: MediaQuery.of(context).padding.top + 16,
            right: 16,
            child: const _CloseButton(),
          ),
        ],
      ),
    );
  }
}

@immutable
final class _CloseButton extends StatelessWidget {
  const _CloseButton();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: ColorName.backgroundLight.withValues(alpha: 0.2),
      shape: const CircleBorder(),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () => Navigator.of(context).pop(),
        child: Container(
          padding: VPadding.all(),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(
              color: ColorName.backgroundLight.withValues(alpha: 0.3),
            ),
          ),
          child: const Icon(
            Icons.close_rounded,
            color: ColorName.backgroundLight,
            size: 24,
          ),
        ),
      ),
    );
  }
}
