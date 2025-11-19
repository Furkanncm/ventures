import 'package:flutter/material.dart';
import 'package:share_plus/share_plus.dart';
import 'package:ventures/common/utils/enum/share_type.dart';
import 'package:ventures/common/utils/extensions/share_extension.dart';

@immutable
final class ShareRepository {
  const ShareRepository._();

  static ShareRepository? _instance;

  static ShareRepository get instance {
    _instance ??= const ShareRepository._();
    return _instance!;
  }

  Future<ShareResultStatus> share(
    String url,
    ShareType shareTpye,
  ) async {
    final result = await SharePlus.instance.share(
      ShareParams(
        uri: Uri.parse(url),
        subject: shareTpye.subject,
        title: shareTpye.title,
      ),
    );
    return result.status;
  }
}
