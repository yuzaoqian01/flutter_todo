import 'package:flutter/material.dart';

class FindPage extends StatefulWidget {
  const FindPage({super.key});

  @override
  State<FindPage> createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('发现'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Find Page'),
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