import 'package:flutter/material.dart';

class MePage extends StatefulWidget {
  const MePage({super.key});

  @override
  State<MePage> createState() => _MePageState();
}

class _MePageState extends State<MePage> {
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
            const Text('Me Page'),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pushNamed('/field');
              },
              child: const Text('Go to Field Page'),
            ),
          ],
        ),
      ),
    );
  }
}