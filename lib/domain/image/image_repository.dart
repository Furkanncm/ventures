import 'dart:io' show Directory, File;

import 'package:flutter/foundation.dart';
import 'package:image_gallery_saver_plus/image_gallery_saver_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:stability_image_generation/stability_image_generation.dart';
import 'package:ventures/common/utils/enum/share_prefs_keys.dart';
import 'package:ventures/data/data_source/remote/image_remote_ds.dart';
import 'package:ventures/domain/shared_pref/share_pref_manager.dart';

abstract class IImageRepository {
  String? get uid;

  Future<(Uint8List, File)> generateImage(
    String prompt, {
    ImageAIStyle imageAiStyle = ImageAIStyle.studioPhoto,
  });

  Future<File> saveImage(Uint8List bytes, String fileName);

  Future<Uint8List?> loadImage(String fileName);

  Future<List<File>> listImages();

  Future<void> deleteImage(String fileName);

  Future<void> clearAll();

  Future<bool> saveImageToGallery(Uint8List bytes, String fileName);
}

class ImageRepository implements IImageRepository {
  ImageRepository(this.remote);
  final ImageRemoteDS remote;

  @override
  String? get uid =>
      SharedPrefsManager().getString(SharedPrefsKeys.isUserLoggedIn);

  @override
  Future<(Uint8List, File)> generateImage(
    String prompt, {
    ImageAIStyle imageAiStyle = ImageAIStyle.studioPhoto,
  }) async {
    final result = await remote.generateImage(prompt);

    final imageFile = await saveImage(
      result,
      'image_${DateTime.now().millisecondsSinceEpoch}.png',
    );

    return (result, imageFile);
  }

  @override
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
  @override
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
  @override
  Future<List<File>> listImages() async {
    final dir = await _userImagesDirectory;
    return dir.listSync().whereType<File>().toList();
  }

  /// Bu kullanıcıya ait tek resmi sil
  @override
  Future<void> deleteImage(String fileName) async {
    final dir = await _userImagesDirectory;
    final file = File('${dir.path}/$fileName');

    if (await file.exists()) {
      await file.delete();
    }
  }

  /// Bu kullanıcının tüm resimlerini sil
  @override
  Future<void> clearAll() async {
    final dir = await _userImagesDirectory;

    if (await dir.exists()) {
      await dir.delete(recursive: true);
    }
  }

  /// Galeriye kaydet
  @override
  Future<bool> saveImageToGallery(Uint8List bytes, String fileName) async {
    final result = await ImageGallerySaverPlus.saveImage(
      bytes,
      name: fileName,
      quality: 100,
    );

    return (result['isSuccess'] ?? false) as bool;
  }
}
