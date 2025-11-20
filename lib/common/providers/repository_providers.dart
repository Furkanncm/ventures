import 'dart:async';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:riverpod/src/providers/stream_provider.dart';
import 'package:ventures/data/remote/auth_remote_ds.dart';
import 'package:ventures/data/remote/image_remote_ds.dart';
import 'package:ventures/data/remote/store_remote_ds.dart';
import 'package:ventures/domain/auth/auth_repository.dart';
import 'package:ventures/domain/cache/cache_repository.dart';
import 'package:ventures/domain/image/image_repository.dart';
import 'package:ventures/domain/user/user_repository.dart';
import 'package:ventures/presentation/auth/login/viewmodel/login_notifier.dart';
import 'package:ventures/presentation/auth/login/viewmodel/login_state.dart';
import 'package:ventures/presentation/auth/sign_up/viewmodel/sign_up_notifier.dart';
import 'package:ventures/presentation/auth/sign_up/viewmodel/sign_up_state.dart';
import 'package:ventures/presentation/image/viewmodel/image_generation_notifier.dart';
import 'package:ventures/presentation/image/viewmodel/image_generation_state.dart';
import 'package:ventures/presentation/profile/viewmodel/profile_notifier.dart';
import 'package:ventures/presentation/profile/viewmodel/profile_state.dart';

// ---------------------------------------------------------------------------
// AUTH REPOSITORY
// ---------------------------------------------------------------------------

final Provider<AuthRepository> authRepositoryProvider =
    Provider.autoDispose<AuthRepository>((ref) {
      final authRemoteDS = AuthRemoteDS();
      final storeRemoteDS = StoreRemoteDS();
      return AuthRepository(
        authRemoteDS: authRemoteDS,
        storeRemoteDS: storeRemoteDS,
      );
    });

// ---------------------------------------------------------------------------
// USER REPOSITORY
// ---------------------------------------------------------------------------

final userRepositoryProvider = Provider<IUserRepository>((ref) {
  final remoteDS = StoreRemoteDS();
  return UserRepository(remoteDS);
});

// ---------------------------------------------------------------------------
// PROFILE NOTIFIER
// ---------------------------------------------------------------------------

final StateNotifierProvider<ProfileNotifier, ProfileState>
profileNotifierProvider =
    StateNotifierProvider.autoDispose<ProfileNotifier, ProfileState>((ref) {
      final userRepository = ref.read(userRepositoryProvider);
      final cacheRepository = ref.read(cacheRepositoryProvider);
      final authRepository = ref.read(authRepositoryProvider);

      return ProfileNotifier(
        userRepository,
        cacheRepository,
        authRepository,
      );
    });

// ---------------------------------------------------------------------------
// LOGIN NOTIFIER
// ---------------------------------------------------------------------------

final StateNotifierProvider<LoginNotifier, LoginState> loginNotifierProvider =
    StateNotifierProvider.autoDispose<LoginNotifier, LoginState>(
      (ref) => LoginNotifier(ref.read(authRepositoryProvider)),
    );

// ---------------------------------------------------------------------------
// SIGNUP NOTIFIER
// ---------------------------------------------------------------------------

final StateNotifierProvider<SignUpNotifier, SignUpState>
signUpNotifierProvider =
    StateNotifierProvider.autoDispose<SignUpNotifier, SignUpState>(
      (ref) => SignUpNotifier(ref.read(authRepositoryProvider)),
    );

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
      final remote = ImageRemoteDS(StoreRemoteDS());
      return ImageRepository(remote);
    });

final StateNotifierProvider<ImageGenerationNotifier, ImageGenerationState>
imageGenerationProvider =
    StateNotifierProvider.autoDispose<
      ImageGenerationNotifier,
      ImageGenerationState
    >((ref) {
      return ImageGenerationNotifier(ref.read(imageRepoProvider));
    });
final FutureProvider<List<File>> imageHistoryProvider =
    FutureProvider.autoDispose<List<File>>((ref) async {
      final repo = ref.watch(imageRepoProvider);
      return repo.listImages();
    });
