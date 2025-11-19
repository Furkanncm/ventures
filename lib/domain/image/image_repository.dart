import 'dart:io' show Directory, File;

import 'package:flutter/foundation.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:ventures/common/utils/enum/pref_keys.dart';
import 'package:ventures/data/remote/image_remote_ds.dart';
import 'package:ventures/domain/cache/cache_repository.dart';
abstract class IImageRepository {
  /// Kullanıcı UID'si
  String? get uid;

  /// Prompt'tan görüntü üretir ve kaydeder
  Future<Uint8List> generateImage(String prompt);

  /// Görüntüyü UID klasörüne kaydeder
  Future<File> saveImage(Uint8List bytes, String fileName);

  /// Belirli bir resmi yükler
  Future<Uint8List?> loadImage(String fileName);

  /// Kullanıcının tüm resimlerini listeler
  Future<List<File>> listImages();

  /// Belirli bir resmi siler
  Future<void> deleteImage(String fileName);

  /// Bu kullanıcıya ait tüm resimleri siler
  Future<void> clearAll();

  /// Galeriye kaydeder (Android & iOS)
  Future<bool> saveImageToGallery(Uint8List bytes, String fileName);
}
class ImageRepository implements IImageRepository{
  ImageRepository(this.remote);
  final ImageRemoteDS remote;

  String? get uid =>
      CacheRepository.instance.getString(PrefKeys.isUserLoggedIn);

  /// Yeni resim oluştur → UID klasörüne kaydet → bytes'ı geri döndür
  Future<Uint8List> generateImage(String prompt) async {
    final result = await remote.generateImage(prompt);

    await saveImage(
      result,
      'image_${DateTime.now().millisecondsSinceEpoch}.png',
    );

    return result;
  }

  /// UID altına resim kaydet
  Future<File> saveImage(Uint8List bytes, String fileName) async {
    final dir = await _userImagesDirectory;
    final file = File('${dir.path}/$fileName');
    return file.writeAsBytes(bytes, flush: true);
  }

  /// Her kullanıcıya özel images/<uid> klasörü
  Future<Directory> get _userImagesDirectory async {
    final userId = uid ?? 'guest';

    final baseDir = await getApplicationDocumentsDirectory();
    final userDir = Directory('${baseDir.path}/images/$userId');

    if (!await userDir.exists()) {
      await userDir.create(recursive: true);
    }

    return userDir;
  }

  /// UID klasöründen bir resmi yükle
  Future<Uint8List?> loadImage(String fileName) async {
    try {
      final dir = await _userImagesDirectory;
      final file = File('${dir.path}/$fileName');

      if (await file.exists()) {
        return file.readAsBytes();
      }
      return null;
    } catch (e) {
      print('Image load error: $e');
      return null;
    }
  }

  /// Bu kullanıcıya ait tüm resimleri listele
  Future<List<File>> listImages() async {
    final dir = await _userImagesDirectory;
    return dir.listSync().whereType<File>().toList();
  }

  /// Bu kullanıcıya ait tek resmi sil
  Future<void> deleteImage(String fileName) async {
    final dir = await _userImagesDirectory;
    final file = File('${dir.path}/$fileName');

    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Bu kullanıcının tüm resimlerini sil
  Future<void> clearAll() async {
    final dir = await _userImagesDirectory;

    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
  }

  /// Galeriye kaydet
  Future<bool> saveImageToGallery(Uint8List bytes, String fileName) async {
    final result = await ImageGallerySaverPlus.saveImage(
      bytes,
      name: fileName,
      quality: 100,
    );

    return (result['isSuccess'] ?? false) as bool;
  }
}
