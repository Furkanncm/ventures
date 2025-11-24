import 'package:codegen/gen/colors.gen.dart';
import 'package:flutter/material.dart';
import 'package:ventures/common/utils/enum/feature_type.dart';
import 'package:ventures/common/utils/extensions/feature_type_extension.dart'; // Extension importu
import 'package:ventures/common/widgets/sized_box/v_sized_box.dart';
import 'package:ventures/common/widgets/text/v_fadded_text.dart';

@immutable
final class NotFound extends StatelessWidget {
  const NotFound({
    required this.type, // Hangi özellik için olduğunu alıyoruz
    super.key,
  });

  final FeatureType type;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            type.icon, // Extension'dan gelen dinamik ikon
            size: 64,
            color: ColorName.gray,
          ),
          VSizedBox.verticalBox16,
          VFaddedText(
            text: type.emptyHistoryMessage, // Extension'dan gelen dinamik mesaj
          ),
        ],
      ),
    );
  }
}