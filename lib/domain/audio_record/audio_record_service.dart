import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:ventures/common/utils/enum/pref_keys.dart';
import 'package:ventures/common/utils/enum/share_prefs_keys.dart';
import 'package:ventures/data/model/text_to_speech/audio_record.dart';
import 'package:ventures/domain/cache/cache_repository.dart';
import 'package:ventures/domain/shared_pref/share_pref_manager.dart';

class TextToSpeechHistoryService {
  final Uuid _uuid = const Uuid();
  final SharedPrefsManager _prefsManager = SharedPrefsManager();

  /// Anlık kullanıcı ID'sini çeker.
  String? get _currentUid => CacheRepository.instance.getString(
    PrefKeys.isUserLoggedIn,
  );

  /// Ses dosyasını kaydeder ve geçmişe ekler.
  Future<AudioRecord> saveAudio({
    required Uint8List bytes,
    required String text,
  }) async {
    final uid = _currentUid;
    if (uid == null) {
      throw Exception('Kullanıcı oturumu bulunamadı, kayıt yapılamaz.');
    }

    // 1. Dosyayı fiziksel olarak kaydet
    final directory = await getApplicationDocumentsDirectory();
    final id = _uuid.v4();
    final filePath = '${directory.path}/$id.mp3';
    final file = File(filePath);

    await file.writeAsBytes(bytes);

    // 2. Kayıt objesini oluştur (userId ile birlikte)
    final record = AudioRecord(
      id: id,
      userId: uid,
      filePath: filePath,
      text: text,
      createdAt: DateTime.now(),
    );

    // 3. Listeye ekle
    await _addToHistory(record);

    return record;
  }

  /// Geçmiş kayıtlarını getirir (Eski veri düzeltmesi içerir).
  Future<List<AudioRecord>> getHistory() async {
    final uid = _currentUid;
    if (uid == null) return [];

    final jsonStringList = _prefsManager.getStringList(
      SharedPrefsKeys.audioHistory,
    );

    if (jsonStringList == null) return [];

    final records =
        jsonStringList
            .map((item) {
              final decodedMap = jsonDecode(item) as Map<String, dynamic>;

              // --- MIGRATION (ESKİ VERİ KURTARMA) ---
              // Eğer eski kayıtlarda userId yoksa, hata almamak için
              // şu anki kullanıcının ID'sini atıyoruz.
              if (decodedMap['userId'] == null) {
                decodedMap['userId'] = uid;
              }
              // ---------------------------------------

              return AudioRecord.fromJson(decodedMap);
            })
            // Sadece bu kullanıcıya ait olanları filtrele
            .where((record) => record.userId == uid)
            .toList()
          // Tarihe göre sırala (Yeniden eskiye)
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return records;
  }

  /// Kaydı siler.
  Future<void> deleteRecord(AudioRecord record) async {
    try {
      // 1. Dosyayı diskten sil
      final file = File(record.filePath);
      if (await file.exists()) {
        await file.delete();
      }

      // 2. Listeden silmek için tüm listeyi çek
      final jsonStringList = _prefsManager.getStringList(
        SharedPrefsKeys.audioHistory,
      );

      if (jsonStringList == null) return;

      // Tüm kayıtları parse et (Migration mantığı burada da gerekli)
      final allRecords = jsonStringList.map((item) {
        final decodedMap = jsonDecode(item) as Map<String, dynamic>;

        if (decodedMap['userId'] == null) {
          decodedMap['userId'] = _currentUid ?? 'unknown';
        }

        return AudioRecord.fromJson(decodedMap);
      }).toList();

      // İlgili kaydı listeden çıkar
      allRecords.removeWhere((element) => element.id == record.id);

      // Listeyi tekrar JSON yapıp kaydet
      final newJsonList = allRecords
          .map((e) => jsonEncode(e.toJson()))
          .toList();

      await _prefsManager.setStringList(
        SharedPrefsKeys.audioHistory,
        newJsonList,
      );
    } catch (e) {
      debugPrint('Silme işlemi sırasında hata: $e');
    }
  }

  /// Yardımcı metod: Listeye yeni kayıt ekler.
  Future<void> _addToHistory(AudioRecord record) async {
    final history =
        _prefsManager.getStringList(SharedPrefsKeys.audioHistory) ?? []
          ..add(jsonEncode(record.toJson()));

    await _prefsManager.setStringList(SharedPrefsKeys.audioHistory, history);
  }
}
