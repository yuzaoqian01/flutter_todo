import 'package:flutter/material.dart';

class FieldPage extends StatelessWidget {
  const FieldPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Field Page'),
      ),
      body: Center(
        child: Text(
          'This is the Field Page',
        ),
      ),
    );
  }
}