
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

  /// [filePath]: Cihazdaki dosyanın tam yolu (örn: /data/user/0/.../image_123.png)
  Future<ShareResultStatus> shareImage(
    String filePath,
    ShareType shareType,
  ) async {
    // Dosya yolunu XFile'a çeviriyoruz
    final file = XFile(filePath);

    final result = await Share.shareXFiles(
      [file], // Paylaşılacak dosyalar listesi
      subject: shareType.subject, // Genellikle E-posta konularında görünür
      text: shareType.title,      // Resmin yanında gidecek mesaj/açıklama
    );

    return result.status;
  }
}
