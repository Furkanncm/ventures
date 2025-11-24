import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:ventures/data/data_source/remote/auth_remote_ds.dart';
import 'package:ventures/data/data_source/remote/chat_remote_ds.dart';
import 'package:ventures/data/data_source/remote/document_remote_ds.dart';
import 'package:ventures/data/data_source/remote/image_remote_ds.dart';
import 'package:ventures/data/data_source/remote/store_remote_ds.dart';
import 'package:ventures/data/model/document_analysis/document_analysis_record.dart';
import 'package:ventures/data/model/text_to_speech/audio_record.dart';
import 'package:ventures/domain/auth/auth_repository.dart';
import 'package:ventures/domain/chat/chat_repository.dart';
import 'package:ventures/domain/document/document_repository.dart';
import 'package:ventures/domain/history/history_repository.dart';
import 'package:ventures/domain/history/history_service.dart';
import 'package:ventures/domain/image/image_repository.dart';
import 'package:ventures/domain/image_picker/image_picker_repository.dart';
import 'package:ventures/domain/shared_pref/share_pref_manager.dart';
import 'package:ventures/domain/text_to_speech/text_to_speech_repository.dart';
import 'package:ventures/domain/user/user_repository.dart';
import 'package:ventures/presentation/auth/login/viewmodel/login_notifier.dart';
import 'package:ventures/presentation/auth/login/viewmodel/login_state.dart';
import 'package:ventures/presentation/auth/sign_up/viewmodel/sign_up_notifier.dart';
import 'package:ventures/presentation/auth/sign_up/viewmodel/sign_up_state.dart';
import 'package:ventures/presentation/auth/splash/viewmodel/splash_notifier.dart';
import 'package:ventures/presentation/chat/viewmodel/chat_notifier.dart';
import 'package:ventures/presentation/chat/viewmodel/chat_state.dart';
import 'package:ventures/presentation/document_analysis/viewmodel/document_analysis_notifier.dart';
import 'package:ventures/presentation/document_analysis/viewmodel/document_anaysis_state.dart';
import 'package:ventures/presentation/image/viewmodel/image_generation_notifier.dart';
import 'package:ventures/presentation/image/viewmodel/image_generation_state.dart';
import 'package:ventures/presentation/profile/viewmodel/profile_notifier.dart';
import 'package:ventures/presentation/profile/viewmodel/profile_state.dart';
import 'package:ventures/presentation/text_to_speech/viewmodel/text_to_speech_notifier.dart';
import 'package:ventures/presentation/text_to_speech/viewmodel/text_to_speech_state.dart';

// ---------------------------------------------------------------------------
// DATA SOURCES & REPOSITORIES
// ---------------------------------------------------------------------------

final cacheRepositoryProvider = Provider<SharedPrefsManager>((ref) {
  return SharedPrefsManager();
});

final Provider<AuthRepository> authRepositoryProvider =
    Provider.autoDispose<AuthRepository>((ref) {
      return AuthRepository(
        authRemoteDS: AuthRemoteDS(),
        storeRemoteDS: StorageRemoteDS(),
      );
    });

final userRepositoryProvider = Provider<IUserRepository>((ref) {
  return UserRepository(StorageRemoteDS());
});

final Provider<IImageRepository> imageRepoProvider =
    Provider.autoDispose<IImageRepository>((ref) {
      return ImageRepository(ImageRemoteDS(StorageRemoteDS()));
    });

final ttsRepositoryProvider = Provider<TextToSpeechRepository>((ref) {
  return TextToSpeechRepository();
});

final audioStorageServiceProvider = Provider<HistoryService>((ref) {
  return HistoryService();
});

final historyRepositoryProvider = Provider<IHistoryRepository>((ref) {
  return HistoryRepository(ref.watch(audioStorageServiceProvider));
});

final imagePickerRepositoryProvider = Provider<IImagePickerRepository>((ref) {
  return ImagePickerRepository();
});

final documentRemoteDSProvider = Provider<DocumentRemoteDS>((ref) {
  return DocumentRemoteDS();
});

final documentRepositoryProvider = Provider<IDocumentRepository>((ref) {
  return DocumentRepository(ref.read(documentRemoteDSProvider));
});

final chatRemoteDSProvider = Provider<ChatRemoteDS>((ref) {
  return ChatRemoteDS();
});

final chatRepositoryProvider = Provider<IChatRepository>((ref) {
  return ChatRepository(ref.read(chatRemoteDSProvider));
});

// ---------------------------------------------------------------------------
// NOTIFIERS (VIEW MODELS)
// ---------------------------------------------------------------------------

final StateNotifierProvider<SplashNotifier, SplashStatus> splashProvider =
    StateNotifierProvider.autoDispose<SplashNotifier, SplashStatus>((ref) {
      return SplashNotifier(
        ref.read(userRepositoryProvider),
        ref.read(cacheRepositoryProvider),
      );
    });

final StateNotifierProvider<ProfileNotifier, ProfileState>
profileNotifierProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((
  ref,
) {
  return ProfileNotifier(
    ref.read(userRepositoryProvider),
    ref.read(cacheRepositoryProvider),
    ref.read(authRepositoryProvider),
  );
});

final StateNotifierProvider<LoginNotifier, LoginState> loginNotifierProvider =
    StateNotifierProvider.autoDispose<LoginNotifier, LoginState>(
      (ref) => LoginNotifier(
        ref.read(authRepositoryProvider),
        ref.read(userRepositoryProvider),
        ref,
      ),
    );

final StateNotifierProvider<SignUpNotifier, SignUpState>
signUpNotifierProvider =
    StateNotifierProvider.autoDispose<SignUpNotifier, SignUpState>(
      (ref) => SignUpNotifier(
        ref.read(authRepositoryProvider),
        ref.read(userRepositoryProvider),
        ref,
      ),
    );

final StateNotifierProvider<ImageGenerationNotifier, ImageGenerationState>
imageGenerationProvider =
    StateNotifierProvider.autoDispose<
      ImageGenerationNotifier,
      ImageGenerationState
    >((ref) {
      return ImageGenerationNotifier(ref.read(imageRepoProvider), ref);
    });

final StateNotifierProvider<TextToSpeechNotifier, TextToSpeechState>
ttsProvider =
    StateNotifierProvider.autoDispose<TextToSpeechNotifier, TextToSpeechState>((
      ref,
    ) {
      return TextToSpeechNotifier(
        ref, // Ref eklendi
        ref.watch(ttsRepositoryProvider),
        ref.watch(historyRepositoryProvider),
      );
    });

final StateNotifierProvider<DocumentAnalysisNotifier, DocumentAnalysisState>
documentAnalysisProvider =
    StateNotifierProvider.autoDispose<
      DocumentAnalysisNotifier,
      DocumentAnalysisState
    >((ref) {
      return DocumentAnalysisNotifier(
        ref.read(documentRepositoryProvider),
        ref.read(imagePickerRepositoryProvider),
        ref.read(userRepositoryProvider),
        ref.read(historyRepositoryProvider),
        ref,
      );
    });

final StateNotifierProvider<ChatNotifier, ChatState> chatProvider =
    StateNotifierProvider.autoDispose<ChatNotifier, ChatState>((ref) {
      return ChatNotifier(ref.read(chatRepositoryProvider));
    });

// ---------------------------------------------------------------------------
// LIST & FUTURE PROVIDERS
// ---------------------------------------------------------------------------

final FutureProvider<List<File>> imageHistoryProvider =
    FutureProvider.autoDispose<List<File>>((ref) async {
      final repo = ref.watch(imageRepoProvider);
      return repo.listImages();
    });

final FutureProvider<List<AudioRecord>> historyListProvider =
    FutureProvider.autoDispose<List<AudioRecord>>((ref) async {
      final repository = ref.watch(historyRepositoryProvider);
      return repository.getAllRecords();
    });

final FutureProvider<List<DocumentAnalysisRecord>> documentHistoryListProvider =
    FutureProvider.autoDispose<List<DocumentAnalysisRecord>>((ref) async {
      final repository = ref.watch(historyRepositoryProvider);
      return repository.getDocumentRecords();
    });

final StreamProvider<List<Map<String, dynamic>>> publicImagesProvider =
    StreamProvider.autoDispose<List<Map<String, dynamic>>>((ref) {
      final controller = StreamController<List<Map<String, dynamic>>>();

      FirebaseFirestore.instance.collection('users').snapshots().listen((snap) {
        final list = <Map<String, dynamic>>[];
        for (final doc in snap.docs) {
          final data = doc.data();
          final publicItems = data['publicItems'] as List<dynamic>? ?? [];
          for (final item in publicItems) {
            list.add(Map<String, dynamic>.from(item as Map));
          }
        }
        controller.add(list);
      });

      return controller.stream;
    });
