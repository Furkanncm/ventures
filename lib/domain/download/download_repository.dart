import 'dart:io';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';

@immutable
final class DownloadRepository {
  const DownloadRepository._();

  static DownloadRepository? _instance;

  static DownloadRepository get instance {
    _instance ??= const DownloadRepository._();
    return _instance!;
  }

  Future<bool> saveAudioToDevice({
    required String filePath,
    required String fileName,
  }) async {
    try {
      final file = File(filePath);
      if (!await file.exists()) return false;

      final bytes = await file.readAsBytes();

      await FileSaver.instance.saveFile(
        name: fileName,
        bytes: bytes,
        ext: 'mp3',
        mimeType: MimeType.mp3,
      );

      return true;
    } catch (e) {
      debugPrint('Download Error: $e');
      return false;
    }
  }
}
