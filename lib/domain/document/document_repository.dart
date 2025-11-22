import 'dart:typed_data';

import 'package:ventures/data/data_source/remote/document_remote_ds.dart';

abstract class IDocumentRepository {
  Future<String> analyzeDocument({
    required Uint8List fileBytes,
    required String mimeType,
    required String prompt,
  });
}

class DocumentRepository implements IDocumentRepository {
  DocumentRepository(this._remoteDS);

  final DocumentRemoteDS _remoteDS;

  @override
  Future<String> analyzeDocument({
    required Uint8List fileBytes,
    required String mimeType,
    required String prompt,
  }) async {
    return _remoteDS.analyzeDocument(
      fileBytes: fileBytes,
      mimeType: mimeType,
      prompt: prompt,
    );
  }
}
