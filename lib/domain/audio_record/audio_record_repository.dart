import 'dart:typed_data';

import 'package:ventures/data/model/text_to_speech/audio_record.dart';
import 'package:ventures/domain/audio_record/audio_record_service.dart';

abstract class IHistoryRepository {
  Future<List<AudioRecord>> getAllRecords();

  Future<AudioRecord> saveRecord({
    required Uint8List bytes,
    required String text,
  });

  Future<void> deleteRecord(AudioRecord record);
}

class HistoryRepository implements IHistoryRepository {
  HistoryRepository(this._storageService);
  final TextToSpeechHistoryService _storageService;

  @override
  Future<List<AudioRecord>> getAllRecords() async {
    try {
      return await _storageService.getHistory();
    } catch (e) {
      throw Exception('Geçmiş getirilirken hata oluştu: $e');
    }
  }

  @override
  Future<AudioRecord> saveRecord({
    required Uint8List bytes,
    required String text,
  }) async {
    try {
      return await _storageService.saveAudio(bytes: bytes, text: text);
    } catch (e) {
      throw Exception('Kayıt sırasında hata oluştu: $e');
    }
  }

  @override
  Future<void> deleteRecord(AudioRecord record) async {
    try {
      await _storageService.deleteRecord(record);
    } catch (e) {
      throw Exception('Silme işlemi başarısız: $e');
    }
  }
}
