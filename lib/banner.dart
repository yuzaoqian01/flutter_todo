import 'package:flutter/material.dart';

class Banner extends StatefulWidget {
  const Banner({super.key});

  @override
  State<Banner> createState() => _BannerState();
}

class _BannerState extends State<Banner> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          child: Text(_index.toString()),
        ),
        Container(
          padding: EdgeInsets.all(10),
          color: Colors.red,
          child: Text('Banner'),
        ),
        ElevatedButton(onPressed: (){
          setState(() {
            _index += 1;
          });
        }, child: const Text('你好')),
      ],
    );
  }
}