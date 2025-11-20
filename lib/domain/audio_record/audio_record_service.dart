import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:ventures/common/utils/enum/share_prefs_keys.dart';
import 'package:ventures/data/model/text_to_speech/audio_record.dart';
import 'package:ventures/domain/shared_pref/share_pref_manager.dart';

class TextToSpeechHistoryService {
  final Uuid _uuid = const Uuid();
  final SharedPrefsManager _prefsManager = SharedPrefsManager();

  Future<AudioRecord> saveAudio({
    required Uint8List bytes,
    required String text,
  }) async {
    final directory = await getApplicationDocumentsDirectory();
    final id = _uuid.v4();
    final filePath = '${directory.path}/$id.mp3';
    final file = File(filePath);

    await file.writeAsBytes(bytes);

    final record = AudioRecord(
      id: id,
      filePath: filePath,
      text: text,
      createdAt: DateTime.now(),
    );

    await _addToHistory(record);

    return record;
  }

  Future<List<AudioRecord>> getHistory() async {
    final jsonStringList = _prefsManager.getStringList(
      SharedPrefsKeys.audioHistory,
    );

    if (jsonStringList == null) return [];

    final records = jsonStringList.map((item) {
      final decodedMap = jsonDecode(item) as Map<String, dynamic>;
      return AudioRecord.fromJson(decodedMap);
    }).toList()..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return records;
  }

  Future<void> deleteRecord(AudioRecord record) async {
    try {
      final file = File(record.filePath);
      if (await file.exists()) {
        await file.delete();
      }

      final history = await getHistory();
      history.removeWhere((element) => element.id == record.id);

      final newJsonList = history.map((e) => jsonEncode(e.toJson())).toList();

      await _prefsManager.setStringList(
        SharedPrefsKeys.audioHistory,
        newJsonList,
      );
    } catch (e) {
      debugPrint('Silme işlemi sırasında hata: $e');
    }
  }

  Future<void> _addToHistory(AudioRecord record) async {
    final history =
        _prefsManager.getStringList(SharedPrefsKeys.audioHistory) ?? []
          ..add(jsonEncode(record.toJson()));

    await _prefsManager.setStringList(SharedPrefsKeys.audioHistory, history);
  }
}
