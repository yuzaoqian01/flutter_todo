import 'package:flutter/material.dart';

class FieldPage extends StatefulWidget {
  const FieldPage({super.key});

  @override
  State<FieldPage> createState() => _FieldPageState();
}

class _FieldPageState extends State<FieldPage> {
  
  String? textFieldValue;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Field'),
      ),
      body:  Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('input field $textFieldValue'),
            TextField(
              onChanged: (value) => {
                Navigator.of(context).pushNamed('/inl_well'),
                // setState(() {
                //   textFieldValue = value; 
                // })
              },
              decoration: InputDecoration(
                labelText: 'Enter text',
                border: OutlineInputBorder(),
              ),
            )
          ],
        ),
      ),
    );
  }
}