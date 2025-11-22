import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod/src/providers/stream_provider.dart';
import 'package:ventures/common/utils/enum/pref_keys.dart';
import 'package:ventures/data/data_source/remote/auth_remote_ds.dart';
import 'package:ventures/data/data_source/remote/document_remote_ds.dart';
import 'package:ventures/data/data_source/remote/image_remote_ds.dart';
import 'package:ventures/data/data_source/remote/store_remote_ds.dart';
import 'package:ventures/data/model/document_analysis/document_analysis_record.dart';
import 'package:ventures/data/model/text_to_speech/audio_record.dart';
import 'package:ventures/data/model/user/user_info.dart';
import 'package:ventures/domain/auth/auth_repository.dart';
import 'package:ventures/domain/cache/cache_repository.dart';
import 'package:ventures/domain/document/document_repository.dart';
import 'package:ventures/domain/history/history_repository.dart';
import 'package:ventures/domain/history/history_service.dart';
import 'package:ventures/domain/image/image_repository.dart';
import 'package:ventures/domain/image_picker/image_picker_repository.dart';
import 'package:ventures/domain/text_to_speech/text_to_speech_repository.dart';
import 'package:ventures/domain/user/user_repository.dart';
import 'package:ventures/presentation/auth/login/viewmodel/login_notifier.dart';
import 'package:ventures/presentation/auth/login/viewmodel/login_state.dart';
import 'package:ventures/presentation/auth/sign_up/viewmodel/sign_up_notifier.dart';
import 'package:ventures/presentation/auth/sign_up/viewmodel/sign_up_state.dart';
import 'package:ventures/presentation/auth/splash/viewmodel/splash_notifier.dart';
import 'package:ventures/presentation/document_analysis/viewmodel/document_analysis_notifier.dart';
import 'package:ventures/presentation/document_analysis/viewmodel/document_anaysis_state.dart';
import 'package:ventures/presentation/image/viewmodel/image_generation_notifier.dart';
import 'package:ventures/presentation/image/viewmodel/image_generation_state.dart';
import 'package:ventures/presentation/profile/viewmodel/profile_notifier.dart';
import 'package:ventures/presentation/profile/viewmodel/profile_state.dart';
import 'package:ventures/presentation/text_to_speech/viewmodel/text_to_speech_notifier.dart';
import 'package:ventures/presentation/text_to_speech/viewmodel/text_to_speech_state.dart';

// ---------------------------------------------------------------------------
// AUTH REPOSITORY
// ---------------------------------------------------------------------------

final Provider<AuthRepository> authRepositoryProvider =
    Provider.autoDispose<AuthRepository>((ref) {
      final authRemoteDS = AuthRemoteDS();
      final storeRemoteDS = StorageRemoteDS();
      return AuthRepository(
        authRemoteDS: authRemoteDS,
        storeRemoteDS: storeRemoteDS,
      );
    });

// ---------------------------------------------------------------------------
// USER REPOSITORY
// ---------------------------------------------------------------------------

final userRepositoryProvider = Provider<IUserRepository>((ref) {
  final remoteDS = StorageRemoteDS();
  return UserRepository(remoteDS);
});

// ---------------------------------------------------------------------------
// CACHE
// ---------------------------------------------------------------------------

final cacheRepositoryProvider = Provider<CacheRepository>((ref) {
  return CacheRepository.instance;
});

// ---------------------------------------------------------------------------
// USER DOC STREAM (User Document Stream for all user data)
// ---------------------------------------------------------------------------

final StreamProviderFamily<DocumentSnapshot<Map<String, dynamic>>, String>
userDocProvider = StreamProvider.autoDispose
    .family<DocumentSnapshot<Map<String, dynamic>>, String>((ref, uid) {
      return FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .snapshots();
    });

// ---------------------------------------------------------------------------
// HISTORY STREAM (correct stream version)
// ---------------------------------------------------------------------------
final StreamProviderFamily<List<Map<String, dynamic>>, String>
userHistoryProvider = StreamProvider.autoDispose
    .family<List<Map<String, dynamic>>, String>((ref, uid) {
      // Firebase’den direkt stream alıyoruz
      final stream = FirebaseFirestore.instance
          .collection('users')
          .doc(uid)
          .snapshots();

      return stream.map((snap) {
        final data = snap.data();
        if (data == null) return <Map<String, dynamic>>[];

        final history = data['historyItems'] as List<dynamic>? ?? [];

        return history
            .map((e) => Map<String, dynamic>.from(e as Map<String, dynamic>))
            .toList();
      });
    });

// ---------------------------------------------------------------------------
// PUBLIC IMAGES LOADER (reads all users' publicItems)
// ---------------------------------------------------------------------------

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

final Provider<IImageRepository> imageRepoProvider =
    Provider.autoDispose<IImageRepository>((ref) {
      final remote = ImageRemoteDS(StorageRemoteDS());
      return ImageRepository(remote);
    });

final StateNotifierProvider<ImageGenerationNotifier, ImageGenerationState>
imageGenerationProvider =
    StateNotifierProvider.autoDispose<
      ImageGenerationNotifier,
      ImageGenerationState
    >((ref) {
      return ImageGenerationNotifier(ref.read(imageRepoProvider), ref);
    });
final FutureProvider<List<File>> imageHistoryProvider =
    FutureProvider.autoDispose<List<File>>((ref) async {
      final repo = ref.watch(imageRepoProvider);
      return repo.listImages();
    });

final ttsRepositoryProvider = Provider<TextToSpeechRepository>((ref) {
  return TextToSpeechRepository();
});

final StateNotifierProvider<TextToSpeechNotifier, TextToSpeechState>
ttsProvider =
    StateNotifierProvider.autoDispose<TextToSpeechNotifier, TextToSpeechState>((
      ref,
    ) {
      final ttsRepo = ref.watch(ttsRepositoryProvider);
      final historyRepo = ref.watch(historyRepositoryProvider);
      final userRepo = ref.read(
        userRepositoryProvider,
      ); // YENİ: User Repo lazım

      return TextToSpeechNotifier(ref, ttsRepo, historyRepo, userRepo);
    });

final audioStorageServiceProvider = Provider<HistoryService>((ref) {
  return HistoryService();
});

final historyRepositoryProvider = Provider<IHistoryRepository>((ref) {
  final service = ref.watch(audioStorageServiceProvider);
  return HistoryRepository(service);
});

final FutureProvider<List<AudioRecord>> historyListProvider =
    FutureProvider.autoDispose<List<AudioRecord>>((ref) async {
      final repository = ref.watch(historyRepositoryProvider);
      return repository.getAllRecords();
    });

final appStartupProvider = FutureProvider<UserInfoModel?>((ref) async {
  // 1. Bağımlılıkları al
  final cache = ref.read(cacheRepositoryProvider);
  final userRepo = ref.read(userRepositoryProvider);

  final uid = cache.getString(PrefKeys.isUserLoggedIn);

  if (uid == null || uid.isEmpty) {
    return null;
  }

  final response = await userRepo.getUser(uid);

  if (response.success ?? false) {
    return response.data;
  } else {
    return null;
  }
});

// SPLASH PROVIDER (Yeni)
final StateNotifierProvider<SplashNotifier, SplashStatus> splashProvider =
    StateNotifierProvider.autoDispose<SplashNotifier, SplashStatus>((ref) {
      return SplashNotifier(
        ref.read(userRepositoryProvider),
        ref.read(cacheRepositoryProvider),
      );
    });

// ---------------------------------------------------------------------------
// PROFILE NOTIFIER (Sadeleşti)
// ---------------------------------------------------------------------------
final StateNotifierProvider<ProfileNotifier, ProfileState>
profileNotifierProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((
  ref,
) {
  final repo = ref.read(userRepositoryProvider);
  final cache = ref.read(cacheRepositoryProvider);
  final auth = ref.read(authRepositoryProvider);

  // ARTIK SADECE BUNLAR YETERLİ:
  return ProfileNotifier(repo, cache, auth);
});

// LOGIN NOTIFIER (GÜNCELLENDİ)
final StateNotifierProvider<LoginNotifier, LoginState> loginNotifierProvider =
    StateNotifierProvider.autoDispose<LoginNotifier, LoginState>(
      (ref) => LoginNotifier(
        ref.read(authRepositoryProvider),
        ref.read(userRepositoryProvider),
        ref, // <--- BURAYA REF EKLİYORUZ
      ),
    );

// ---------------------------------------------------------------------------
// SIGNUP NOTIFIER (User Repo Eklendi)
// ---------------------------------------------------------------------------
final StateNotifierProvider<SignUpNotifier, SignUpState>
signUpNotifierProvider =
    StateNotifierProvider.autoDispose<SignUpNotifier, SignUpState>(
      (ref) => SignUpNotifier(
        ref.read(authRepositoryProvider),
        ref.read(userRepositoryProvider),
        ref, // <--- BURAYA REF EKLİYORUZ
      ),
    );

final imagePickerRepositoryProvider = Provider<IImagePickerRepository>((ref) {
  return ImagePickerRepository();
});
final documentRemoteDSProvider = Provider<DocumentRemoteDS>((ref) {
  return DocumentRemoteDS();
});
final documentRepositoryProvider = Provider<IDocumentRepository>((ref) {
  return DocumentRepository(ref.read(documentRemoteDSProvider));
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
        ref.read(historyRepositoryProvider), // EKLENDİ
        ref,
      );
    });
final FutureProvider<List<DocumentAnalysisRecord>> documentHistoryListProvider =
    FutureProvider.autoDispose<List<DocumentAnalysisRecord>>((ref) async {
      final repository = ref.watch(historyRepositoryProvider);
      return repository.getDocumentRecords();
    });
