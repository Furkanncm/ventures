import 'package:shared_preferences/shared_preferences.dart';
import 'package:ventures/common/utils/enum/share_prefs_keys.dart';

class SharedPrefsManager {
  factory SharedPrefsManager() {
    return _instance;
  }

  SharedPrefsManager._init();
  static final SharedPrefsManager _instance = SharedPrefsManager._init();
  SharedPreferences? _preferences;

  Future<void> init() async {
    _preferences = await SharedPreferences.getInstance();
  }


  Future<void> setStringList(SharedPrefsKeys key, List<String> value) async {
    if (_preferences == null) return;
    await _preferences!.setStringList(key.name, value);
  }

  List<String>? getStringList(SharedPrefsKeys key) {
    if (_preferences == null) return null;
    return _preferences!.getStringList(key.name);
  }


  Future<void> setString(SharedPrefsKeys key, String value) async {
    await _preferences?.setString(key.name, value);
  }

  String? getString(SharedPrefsKeys key) {
    return _preferences?.getString(key.name);
  }

  Future<void> setBool(SharedPrefsKeys key, bool value) async {
    await _preferences?.setBool(key.name, value);
  }

  bool? getBool(SharedPrefsKeys key) {
    return _preferences?.getBool(key.name);
  }

  Future<void> remove(SharedPrefsKeys key) async {
    await _preferences?.remove(key.name);
  }

  Future<void> clear() async {
    await _preferences?.clear();
  }
}
