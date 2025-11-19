import 'package:ventures/common/utils/enum/share_type.dart';

extension ShareExtension on ShareType {
  String get title {
    switch (this) {
      case ShareType.audio:
        return 'Listen to this audio';
      case ShareType.document:
        return 'Check out this document';
      case ShareType.image:
        return 'Look at this image';
    }
  }

  String get subject {
    switch (this) {
      case ShareType.audio:
        return 'Audio File';
      case ShareType.document:
        return 'Document File';
      case ShareType.image:
        return 'Image File';
    }
  }
}