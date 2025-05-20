// 本地存储类

import 'package:shared_preferences/shared_preferences.dart';

class LocalStorage {
  static final locals = Map<String, String>();
  static String get(String key) {
    return locals[key] ?? '';
  }
  static void set(String key, String value) {
    locals[key] = value;
  }
  static void remove(String key) {
    locals.remove(key);
  }
  static void clear() {
    locals.clear();
  }
  static bool containsKey(String key) {
    return locals.containsKey(key);
  }
  static void setBool(String key, bool value) {
    locals[key] = value.toString();
  }
  static bool getBool(String key) {
    return locals[key] == 'true';
  }
  static Future<void> setInt(String key, int value) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt(key, value);
  }

}