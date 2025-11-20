import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:ventures/common/utils/decoration/box_decoration.dart';
import 'package:ventures/common/widgets/button/v_elevated_button.dart';
import 'package:ventures/common/widgets/sized_box/v_sized_box.dart';

@immutable
final class PlayAndShareButton extends StatelessWidget {
  const PlayAndShareButton({
    required this.onPlay,
    required this.onShare,
    super.key,
  });

  final VoidCallback onPlay;
  final VoidCallback onShare;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: VElevatedButton(
            backgroundColor: ColorName.onSuccess,
            onPressed: onPlay,
            icon: const Icon(Icons.play_arrow),
            label: 'Oynat',
          ),
        ),
        VSizedBox.horizontalBox12,
        InkWell(
          onTap: onShare,
          borderRadius: BorderRadius.circular(12),
          child: Container(
            height: 48,
            width: 48,
            decoration: CustomBoxDecoration.shareButton(),
            child: const Icon(Icons.share, color: Colors.blueGrey),
          ),
        ),
      ],
    );
  }
}
