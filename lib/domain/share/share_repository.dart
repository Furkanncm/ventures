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

  Future<ShareResultStatus> _shareFile(
    String filePath,
    ShareType shareType,
  ) async {
    final file = XFile(filePath);

    final result = await Share.shareXFiles(
      [file],
      subject: shareType.subject,
      text: shareType.title,
    );

    return result.status;
  }

  Future<ShareResultStatus> shareAudio(String filePath) async {
    return _shareFile(filePath, ShareType.audio);
  }

  Future<ShareResultStatus> shareImage(String filePath) async {
    return _shareFile(filePath, ShareType.image);
  }

  Future<ShareResultStatus> shareDocument(String filePath) async {
    return _shareFile(filePath, ShareType.document);
  }
}
