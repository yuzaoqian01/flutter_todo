import 'package:flutter/material.dart';

class MyBackPage extends StatefulWidget {
  const MyBackPage({super.key});

  @override
  State<MyBackPage> createState() => _MyBackPageState();
}

class _MyBackPageState extends State<MyBackPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('pop page'),
      ),
      body: ElevatedButton(
        onPressed: (){
          Navigator.pop(context);
        },
         child: Text('click me back')
      ),
    );
  }
}