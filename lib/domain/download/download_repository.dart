import 'dart:io';

import 'package:file_saver/file_saver.dart';
import 'package:flutter/foundation.dart';
import 'package:ventures/common/utils/enum/file_download_type.dart';
// Enum'ı import etmeyi unutma
// import 'package:ventures/common/utils/enum/file_download_type.dart';

@immutable
final class DownloadRepository {
  const DownloadRepository._();

  static DownloadRepository? _instance;

  static DownloadRepository get instance {
    _instance ??= const DownloadRepository._();
    return _instance!;
  }

  Future<bool> _saveFile({
    required String filePath,
    required String fileName,
    required FileDownloadType type,
  }) async {
    try {
      // 1. Kaynak dosya var mı kontrol et
      final sourceFile = File(filePath);
      if (!await sourceFile.exists()) {
        debugPrint('Kaynak dosya bulunamadı: $filePath');
        return false;
      }

      // --- ANDROID İÇİN ÖZEL MANTIK ---
      if (Platform.isAndroid) {
        // İndirilenler klasörünü manuel hedefliyoruz
        // Android 10+ cihazlarda bile bu yol "Downloads" klasörüdür.
        final downloadDir = Directory('/storage/emulated/0/Download');

        if (!await downloadDir.exists()) {
          await downloadDir.create(recursive: true);
        }

        // Dosya adını ve uzantıyı birleştir
        // Örn: /storage/emulated/0/Download/Analiz_Raporu.pdf
        final newPath = '${downloadDir.path}/$fileName.${type.ext}';

        // Dosyayı oraya kopyala
        await sourceFile.copy(newPath);

        debugPrint('Android İndirme Başarılı: $newPath');
        return true;
      }
      // --- IOS İÇİN MANTIK (FileSaver Kullanmaya Devam) ---
      else {
        final bytes = await sourceFile.readAsBytes();
        await FileSaver.instance.saveFile(
          name: fileName,
          bytes: bytes,
          ext: type.ext,
          mimeType: type.mimeType,
        );
        return true;
      }
    } catch (e) {
      debugPrint('${type.name.toUpperCase()} Kaydetme Hatası: $e');
      return false;
    }
  }

  Future<bool> saveAudioToDevice({
    required String filePath,
    required String fileName,
  }) {
    return _saveFile(
      filePath: filePath,
      fileName: fileName,
      type: FileDownloadType.audio,
    );
  }

  Future<bool> saveDocumentToDevice({
    required String filePath,
    required String fileName,
  }) {
    return _saveFile(
      filePath: filePath,
      fileName: fileName,
      type: FileDownloadType.pdf,
    );
  }
}
