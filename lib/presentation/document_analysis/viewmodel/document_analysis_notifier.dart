import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart'; // Legacy kullanıyorsan kalsın
import 'package:ventures/common/providers/repository_providers.dart';
import 'package:ventures/common/utils/constants/string_constants.dart';
import 'package:ventures/common/utils/enum/feature_type.dart';
import 'package:ventures/domain/document/document_repository.dart';
import 'package:ventures/domain/history/history_repository.dart';
import 'package:ventures/domain/image_picker/image_picker_repository.dart';
import 'package:ventures/domain/user/user_repository.dart';
import 'package:ventures/presentation/document_analysis/viewmodel/document_anaysis_state.dart';

class DocumentAnalysisNotifier extends StateNotifier<DocumentAnalysisState> {
  DocumentAnalysisNotifier(
    this._docRepo,
    this._pickerRepo,
    this._userRepo,
    this._historyRepo,
    this.ref,
  ) : super(DocumentAnalysisState.initial());

  final IDocumentRepository _docRepo;
  final IImagePickerRepository _pickerRepo;
  final IUserRepository _userRepo;
  final IHistoryRepository _historyRepo;
  final Ref ref;

  Future<void> pickImage({required bool fromCamera}) async {
    final result = await _pickerRepo.pickImage(fromCamera: fromCamera);

    if (result != null) {
      state = state.copyWith(
        selectedBytes: result.bytes,
        mimeType: result.mimeType,
        fileName: result.name,
      );
    }
  }

  Future<void> pickFile() async {
    final result = await _pickerRepo.pickFile();

    if (result != null) {
      state = state.copyWith(
        selectedBytes: result.bytes,
        mimeType: result.mimeType,
        fileName: result.name,
      );
    }
  }

  Future<void> analyzeDocument(String prompt) async {
    if (state.selectedBytes == null || state.mimeType == null) {
      state = state.copyWith(error: StringConstants.selectDocumentWarning);
      return;
    }

    final user = _userRepo.currentUser;
    if (user == null) {
      state = state.copyWith(error: StringConstants.errorUserNotFound);
      return;
    }

    if (!user.hasCredit(FeatureType.documentAnalysis)) {
      state = state.copyWith(error: StringConstants.freeLimitReached);
      return;
    }

    try {
      if (state.error != null) state = state.copyWith();
      state = state.copyWith(isLoading: true);

      final result = await _docRepo.analyzeDocument(
        fileBytes: state.selectedBytes!,
        mimeType: state.mimeType!,
        prompt: prompt,
      );

      ref
          .read(profileNotifierProvider.notifier)
          .incrementLocalUsage(FeatureType.documentAnalysis);

      await _historyRepo.saveDocumentRecord(
        resultText: result,
        fileBytes: state.selectedBytes,
        mimeType: state.mimeType,
        fileName: state.fileName,
      );

      state = state.copyWith(
        isLoading: false,
        analysisResult: result,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  void clear() {
    state = DocumentAnalysisState.initial();
  }
}
