import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DemoPage extends StatefulWidget {
  @override
  _DemoPageState createState() => _DemoPageState();
}

class _DemoPageState extends State<DemoPage> {

  final movies = Supabase.instance.client.from('movies').select();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: movies,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }
          final datas = snapshot.data!;
          return ListView.builder(
            itemCount: datas.length,
            itemBuilder: ((context, index) {
              final item = datas[index];
              return ListTile(
                title: Text('电影名称：-- ${item['name']}'),
              );
            }),
          );
        },
      ),
    );
  }
}