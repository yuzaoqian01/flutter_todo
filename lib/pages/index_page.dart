import 'package:flutter/material.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页', style: TextStyle(color: Colors.black, fontSize: 20)),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Index Page'),
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
