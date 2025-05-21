import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MePage extends StatefulWidget {
  const MePage({super.key});

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
  String text = '中文测试1234567890';
  String result = '--';
  final storage = const FlutterSecureStorage();

  Future<void> _getSecureStorage() async {
    // const storage = FlutterSecureStorage();
    String? value = await storage.read(key: 'text');
    if (value != null) {
      setState(() {
        result = value;
      });
    } else {
      setState(() {
        result = '没有存储的值';
      });
    }
  }
  Future<void> _setSecureStorage() async {
    // const storage = FlutterSecureStorage();
    final options = IOSOptions(accessibility: KeychainAccessibility.first_unlock_this_device);
    await storage.write(key: 'text', value: text, iOptions: options);
    setState(() {
      result = '存储成功';
    });
  }
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('我的'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('加密前后对比'),
            const SizedBox(height: 20),
            Text(text),
            const SizedBox(height: 20),
            const Text('加密存储的值'),
            const SizedBox(height: 20),
            Text(result),
            ElevatedButton(
              onPressed: () {
               _setSecureStorage();
              },
              child: const Text('加密存储'),
            ),
            ElevatedButton(
              onPressed: () {
                _getSecureStorage();
              },
              child: const Text('读取存储'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/local_auth');
              },
              child: const Text('本地认证'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/file');
              },
              child: const Text('文件存储'),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushNamed(context, '/version');
              },
              child: const Text('版本信息'),
            ),
          ],
        ),
      ),
    );
  }
}