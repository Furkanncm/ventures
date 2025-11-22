import 'dart:typed_data';

import 'package:ventures/data/model/document_analysis/document_analysis_record.dart';
import 'package:ventures/data/model/text_to_speech/audio_record.dart';
import 'package:ventures/domain/history/history_service.dart';

abstract class IHistoryRepository {
  Future<List<AudioRecord>> getAllRecords();

  Future<AudioRecord> saveRecord({
    required Uint8List bytes,
    required String text,
  });

  Future<void> deleteRecord(AudioRecord record);

  Future<List<DocumentAnalysisRecord>> getDocumentRecords();

  Future<DocumentAnalysisRecord> saveDocumentRecord({
    required String resultText,
    required Uint8List? fileBytes,
    String? mimeType,
    String? fileName,
  });

  Future<void> deleteDocumentRecord(DocumentAnalysisRecord record);
}

class HistoryRepository implements IHistoryRepository {
  HistoryRepository(this._storageService);
  final HistoryService _storageService;

  @override
  Future<List<AudioRecord>> getAllRecords() async {
    return _storageService.getHistory();
  }

  @override
  Future<AudioRecord> saveRecord({
    required Uint8List bytes,
    required String text,
  }) async {
    return _storageService.saveAudio(bytes: bytes, text: text);
  }

  @override
  Future<void> deleteRecord(AudioRecord record) async {
    await _storageService.deleteRecord(record);
  }

  @override
  Future<List<DocumentAnalysisRecord>> getDocumentRecords() async {
    return _storageService.getDocumentHistory();
  }

  @override
  Future<DocumentAnalysisRecord> saveDocumentRecord({
    required String resultText,
    required Uint8List? fileBytes,
    String? mimeType,
    String? fileName,
  }) async {
    return _storageService.saveDocumentAnalysis(
      resultText: resultText,
      fileBytes: fileBytes,
      mimeType: mimeType,
      fileName: fileName,
    );
  }

  @override
  Future<void> deleteDocumentRecord(DocumentAnalysisRecord record) async {
    return _storageService.deleteDocumentRecord(record);
  }
}
