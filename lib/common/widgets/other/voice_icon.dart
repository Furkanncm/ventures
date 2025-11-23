import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:ventures/data/model/voice/voice_model.dart';

@immutable
final class VoiceIcon extends StatelessWidget {
  const VoiceIcon({required this.voice, super.key});
  final VoiceModel voice;

  @override
  Widget build(BuildContext context) {
    final isFemale = voice.isFemale;
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isFemale
            ? ColorName.onError.withValues(alpha: 0.1)
            : ColorName.primary.withValues(alpha: 0.1),
        shape: BoxShape.circle,
      ),
      child: Icon(
        isFemale ? Icons.face_3_rounded : Icons.face_6_rounded,
        color: isFemale ? ColorName.onError : ColorName.primary,
        size: 26,
      ),
    );
  }
}