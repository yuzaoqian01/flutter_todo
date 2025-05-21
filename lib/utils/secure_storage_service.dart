import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorageService {
  // 创建单例
  static final SecureStorageService _instance = SecureStorageService._internal();

  factory SecureStorageService() => _instance;

  SecureStorageService._internal();

  final FlutterSecureStorage _storage = const FlutterSecureStorage();

  // final FlutterSecureStorage _storage = const FlutterSecureStorage(
  //   iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  //   aOptions: AndroidOptions(encryptedSharedPreferences: true),
  // );

  /// 写入数据
  Future<void> write(String key, String value) async {
    await _storage.write(key: key, value: value);
  }

  /// 读取数据
  Future<String?> read(String key) async {
    return await _storage.read(key: key);
  }

  /// 删除某个 key
  Future<void> delete(String key) async {
    await _storage.delete(key: key);
  }

  /// 删除所有数据
  Future<void> deleteAll() async {
    await _storage.deleteAll();
  }

  /// 是否包含某个 key（可选功能）
  Future<bool> containsKey(String key) async {
    final all = await _storage.readAll();
    return all.containsKey(key);
  }
}



