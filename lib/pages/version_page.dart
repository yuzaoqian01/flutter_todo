import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';


void getPackageInfo() async {
  PackageInfo packageInfo = await PackageInfo.fromPlatform();

  String appName = packageInfo.appName;
  String packageName = packageInfo.packageName;
  String version = packageInfo.version;
  String buildNumber = packageInfo.buildNumber;
  // ignore: avoid_print
  print('App Name: $appName');
  // ignore: avoid_print
  print('Package Name: $packageName');
  // ignore: avoid_print
  print('Version: $version');
  // ignore: avoid_print
  print('Build Number: $buildNumber');
}

void checkUpdate() async {
  String url = 'http://101.132.114.125:9903/admin/user-wenjuan/list'; // 替换为你的API地址
  final response = await http.get(Uri.parse(url));

  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    // ignore: avoid_print
    print('最新版本: ${data.toString()}');
    // ignore: avoid_print
    print('更新内容: ${data['update_content']}');
  } else {
    // ignore: avoid_print
    print('请求失败，状态码: ${response.statusCode}');
  }
}


class VersionPage extends StatefulWidget {
  const VersionPage({super.key});

  @override
  State<VersionPage> createState() => _VersionPageState();
}

class _VersionPageState extends State<VersionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('版本信息'),
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              // ignore: avoid_print
              print('开始检查更新');
              getPackageInfo();
            },
            child: const Text('检查更新'),
          ),
          ElevatedButton(
            onPressed: () async {
              // ignore: avoid_print
              print('开始获取版本信息');
              checkUpdate();
            },
            child: const Text('获取版本信息'),
          ),
        ],
      ),
    );
  }
}

