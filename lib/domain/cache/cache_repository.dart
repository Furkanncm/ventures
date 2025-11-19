import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventures/common/utils/enum/pref_keys.dart';

abstract class ICacheRepository {
  Future<void> getInstance();

  Future<void> setString(PrefKeys key, String value);
  String? getString(PrefKeys key);

  Future<void> remove(PrefKeys key);
  Future<void> clear();
}

class CacheRepository implements ICacheRepository {
  CacheRepository._init();
  static CacheRepository? _instance;
  static CacheRepository get instance {
    return _instance ??= CacheRepository._init();
  }

  SharedPreferences? _prefs;

  @override
  Future<void> getInstance() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  @override
  Future<bool> setString(PrefKeys key, String value) async =>
      _prefs!.setString(key.rawValue, value);

  @override
  String? getString(PrefKeys key) => _prefs!.getString(key.rawValue);

  @override
  Future<void> remove(PrefKeys key) async => _prefs!.remove(key.rawValue);

  @override
  Future<void> clear() async => _prefs!.clear();
}
