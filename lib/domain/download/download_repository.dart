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

  

  Future<String?> saveAudioToDevice({
    required String filePath,
    required String fileName,
  }) async {
    try {
      // 1. Dosyayı byte olarak oku
      final file = File(filePath);
      if (!await file.exists()) return null;

      final bytes = await file.readAsBytes();

      final path = await FileSaver.instance.saveFile(
        name: fileName, // Dosya adı
        bytes: bytes,
        ext: 'mp3', // Uzantı
        mimeType: MimeType.mp3,
      );

      return path;
    } catch (e) {
      debugPrint('Download Error: $e');
      return null;
    }
  }
}
