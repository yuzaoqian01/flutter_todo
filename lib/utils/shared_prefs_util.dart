import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';


class SharedPrefsUtil {
  // 存储 List<String>
  static Future<bool> saveStringList(String key, List<String> list) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.setStringList(key, list);
  }

  // 读取 List<String>
  static Future<List<String>> getStringList(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getStringList(key) ?? [];
  }

  // 存储 List<T>，其中 T 需实现 toJson() 方法
  static Future<bool> saveObjectList<T>(String key, List<T> list, Map<String, dynamic> Function(T) toJson) async {
    final prefs = await SharedPreferences.getInstance();
    // 把对象列表转成 JSON 字符串列表
    List<String> jsonList = list.map((item) => json.encode(toJson(item))).toList();
    return prefs.setStringList(key, jsonList);
  }

  // 读取 List<T>，其中 fromJson 用于把 Map 转为对象
  static Future<List<T>> getObjectList<T>(String key, T Function(Map<String, dynamic>) fromJson) async {
    final prefs = await SharedPreferences.getInstance();
    List<String>? jsonList = prefs.getStringList(key);
    if (jsonList == null) return [];
    return jsonList.map((jsonStr) {
      final Map<String, dynamic> map = json.decode(jsonStr);
      return fromJson(map);
    }).toList();
  }

  // 清除某个key
  static Future<bool> removeKey(String key) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }
}
