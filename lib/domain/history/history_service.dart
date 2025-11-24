import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:path_provider/path_provider.dart';
import 'package:uuid/uuid.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/share_prefs_keys.dart';
import 'package:ventures/data/model/document_analysis/document_analysis_record.dart';
import 'package:ventures/data/model/text_to_speech/audio_record.dart';
import 'package:ventures/domain/shared_pref/share_pref_manager.dart';

class HistoryService {
  final Uuid _uuid = const Uuid();
  final SharedPrefsManager _prefsManager = SharedPrefsManager();

  String? get _currentUid => SharedPrefsManager().getString(
    SharedPrefsKeys.isUserLoggedIn,
  );

  Future<AudioRecord> saveAudio({
    required Uint8List bytes,
    required String text,
  }) async {
    final uid = _currentUid;
    if (uid == null) {
      throw Exception(StringConstants.noUserLoggedIn);
    }

    final directory = await getApplicationDocumentsDirectory();
    final id = _uuid.v4();
    final filePath = '${directory.path}/$id.mp3';
    final file = File(filePath);

    await file.writeAsBytes(bytes);

    final record = AudioRecord(
      id: id,
      userId: uid,
      filePath: filePath,
      text: text,
      createdAt: DateTime.now(),
    );

    await _addToHistory(record);

    return record;
  }

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
              if (decodedMap['userId'] == null) {
                decodedMap['userId'] = uid;
              }
              return AudioRecord.fromJson(decodedMap);
            })
            .where((record) => record.userId == uid)
            .toList()
          ..sort((a, b) => b.createdAt.compareTo(a.createdAt));

    return records;
  }

  Future<void> deleteRecord(AudioRecord record) async {
    final file = File(record.filePath);
    if (await file.exists()) {
      await file.delete();
    }

    final jsonStringList = _prefsManager.getStringList(
      SharedPrefsKeys.audioHistory,
    );

    if (jsonStringList == null) return;

    final allRecords = jsonStringList.map((item) {
      final decodedMap = jsonDecode(item) as Map<String, dynamic>;
      if (decodedMap['userId'] == null) {
        decodedMap['userId'] = _currentUid ?? 'unknown';
      }
      return AudioRecord.fromJson(decodedMap);
    }).toList()..removeWhere((element) => element.id == record.id);

    final newJsonList = allRecords.map((e) => jsonEncode(e.toJson())).toList();

    await _prefsManager.setStringList(
      SharedPrefsKeys.audioHistory,
      newJsonList,
    );
  }

  Future<void> _addToHistory(AudioRecord record) async {
    final history =
        _prefsManager.getStringList(SharedPrefsKeys.audioHistory) ?? []
          ..add(jsonEncode(record.toJson()));

    await _prefsManager.setStringList(SharedPrefsKeys.audioHistory, history);
  }

  Future<DocumentAnalysisRecord> saveDocumentAnalysis({
    required String resultText,
    required Uint8List? fileBytes,
    String? mimeType,
    String? fileName,
  }) async {
    final uid = _currentUid;
    if (uid == null) {
      throw Exception(StringConstants.noUserLoggedIn);
    }

    final id = _uuid.v4();
    String? savedFilePath;
    var finalFileName = fileName ?? 'document';

    if (fileName != null && fileName.contains('.')) {
      final nameWithoutExt = fileName.substring(0, fileName.lastIndexOf('.'));
      final extension = fileName.substring(fileName.lastIndexOf('.'));
      finalFileName = '${nameWithoutExt}_analyze$extension';
    } else {
      // Uzantı yoksa veya dosya adı yoksa
      final ext = mimeType == 'application/pdf' ? '.pdf' : '.jpg';
      finalFileName = 'doc_${id}_analyze$ext';
    }
    // ------------------------------------------------

    if (fileBytes != null) {
      final directory = await getApplicationDocumentsDirectory();

      savedFilePath = '${directory.path}/$finalFileName';

      final file = File(savedFilePath);
      await file.writeAsBytes(fileBytes);
    }

    final record = DocumentAnalysisRecord(
      id: id,
      userId: uid,
      resultText: resultText,
      createdAt: DateTime.now(),
      imagePath: savedFilePath,
      fileName: finalFileName,
    );

    await _addToDocumentHistory(record);

    return record;
  }

  Future<List<DocumentAnalysisRecord>> getDocumentHistory() async {
    final uid = _currentUid;
    if (uid == null) return [];

    final jsonStringList = _prefsManager.getStringList(
      SharedPrefsKeys.documentHistory,
    );

    if (jsonStringList == null) return [];

    return jsonStringList
        .map((item) {
          final jsonMap = jsonDecode(item) as Map<String, dynamic>;
          return DocumentAnalysisRecord.fromJson(jsonMap);
        })
        .where((record) => record.userId == uid)
        .toList()
      ..sort((a, b) => b.createdAt.compareTo(a.createdAt));
  }

  Future<void> _addToDocumentHistory(DocumentAnalysisRecord record) async {
    final history =
        _prefsManager.getStringList(SharedPrefsKeys.documentHistory) ?? []
          ..add(jsonEncode(record.toJson()));

    await _prefsManager.setStringList(SharedPrefsKeys.documentHistory, history);
  }

  Future<void> deleteDocumentRecord(DocumentAnalysisRecord record) async {
    if (record.imagePath != null) {
      final file = File(record.imagePath!);
      if (await file.exists()) {
        await file.delete();
      }
    }

    final jsonStringList = _prefsManager.getStringList(
      SharedPrefsKeys.documentHistory,
    );

    if (jsonStringList == null) return;

    final allRecords = jsonStringList.map((item) {
      final decodedMap = jsonDecode(item) as Map<String, dynamic>;
      return DocumentAnalysisRecord.fromJson(decodedMap);
    }).toList()..removeWhere((element) => element.id == record.id);

    final newJsonList = allRecords.map((e) => jsonEncode(e.toJson())).toList();

    await _prefsManager.setStringList(
      SharedPrefsKeys.documentHistory,
      newJsonList,
    );
  }
}
