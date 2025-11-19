import 'package:codegen/gen/assets.gen.dart';
import 'package:flutter/material.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';

extension AssetsExtension on AssetGenImage {
  Image get toImage =>
      image(package: StringConstants.imagePackage, fit: BoxFit.cover);
  Image get toAppIcon => image(
    package: StringConstants.imagePackage,
    height: 128,
    alignment: AlignmentGeometry.centerLeft,
  );
  Image get toIcon => image(
    package: StringConstants.imagePackage,
    height: 24,
    alignment: AlignmentGeometry.centerLeft,
  );
}
