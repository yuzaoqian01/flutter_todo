import 'package:flutter/material.dart';
import 'package:todo/services/local_auth_service.dart';

class LocalAuthPage extends StatefulWidget {
  const LocalAuthPage({super.key});

  @override
  State<LocalAuthPage> createState() => _LocalAuthPageState();
}

class _LocalAuthPageState extends State<LocalAuthPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('本地认证'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('本地认证测试'),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final result = await LocalAuthService().authenticate();
                if (result) {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('认证成功')),
                  );
                } else {
                  // ignore: use_build_context_synchronously
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('认证失败')),
                  );
                }
              },
              child: const Text('开始认证'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final isSupported = await LocalAuthService().isDeviceSupported();
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('设备支持：$isSupported')),
                );
              },
              child: const Text('检查设备支持'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final canCheck = await LocalAuthService().canCheckBiometrics();
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('可以检查生物识别：$canCheck')),
                );
              },
              child: const Text('检查生物识别'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final biometrics = await LocalAuthService().getAvailableBiometrics();
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('可用的生物识别类型：$biometrics')),
                );
              },
              child: const Text('获取可用的生物识别类型'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final result = await LocalAuthService().authenticate(
                  reason: '请验证身份以继续',
                  useErrorDialogs: true,
                  stickyAuth: false,
                );
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('认证结果：$result')),
                );
              },
              child: const Text('自定义认证'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final result = await LocalAuthService().authenticate(
                  reason: '请验证身份以继续',
                  useErrorDialogs: true,
                  stickyAuth: true,
                );
                // ignore: use_build_context_synchronously
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('认证结果：$result')),
                );
              },
              child: const Text('粘性认证'),
            ),
          ],
        ),
      ),
    );
  }
}