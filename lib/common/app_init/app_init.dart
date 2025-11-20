import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:ventures/common/network/dio_manager.dart';
import 'package:ventures/domain/cache/cache_repository.dart';
import 'package:ventures/domain/shared_pref/share_pref_manager.dart';
import 'package:ventures/firebase_options.dart';

@immutable
final class AppInit {
  Future<void> initialize() async {
    WidgetsFlutterBinding.ensureInitialized();
    await dotenv.load();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    await CacheRepository.instance.getInstance();

    await DioManager().init();

    await SharedPrefsManager().init();
  }
}
