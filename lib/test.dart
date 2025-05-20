import 'package:flutter/material.dart';

class Test extends StatelessWidget {
  const Test({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(flex: 1, child: Text('1')),
        Expanded(flex: 2, child: Text('2'))
      ],
    );
  }
}