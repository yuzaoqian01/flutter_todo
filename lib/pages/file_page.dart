import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';

class FilePage extends StatefulWidget {
  const FilePage({super.key});

  @override
  State<FilePage> createState() => _FilePageState();
}

class _FilePageState extends State<FilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('文件管理'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('创建文件测试'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final directory = await getApplicationDocumentsDirectory();
                final file = File('${directory.path}/test.txt');
                await file.writeAsString('Hello, Flutter!');
                // ignore: avoid_print
                print('文件创建成功，路径：${file.path}');
              },
              child: const Text('获取应用文档目录'),
            ),
            Text('读取文件测试'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final directory = await getApplicationDocumentsDirectory();
                final file = File('${directory.path}/test.txt');
                if (await file.exists()) {
                  final content = await file.readAsString();
                  
                  // ignore: avoid_print
                  print('文件内容：$content');

                } else {
                  // ignore: avoid_print
                  print('文件不存在');

                }
              },
              child: const Text('读取文件'),
            ),

            const Text('文件存储测试'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final directory = await getApplicationDocumentsDirectory();
                final path = directory.path;
                // ignore: avoid_print
                print('应用文档目录：$path');
              },
              child: const Text('获取应用文档目录'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final directory = await getTemporaryDirectory();
                final path = directory.path;
                // ignore: avoid_print
                print('临时目录：$path');
              },
              child: const Text('获取临时目录'),
            ),
            const SizedBox(height: 20), 
            ElevatedButton(
              onPressed: () async {
                final directory = await getDownloadsDirectory();
                final path = directory?.path ?? '不支持下载目录';
                // ignore: avoid_print
                print('下载目录：$path');
              },
              child: const Text('获取下载目录'),
            ),
          ],
        ),
      ),
    );
  }
}