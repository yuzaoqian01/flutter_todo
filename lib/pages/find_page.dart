import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class FindPage extends StatefulWidget {
  const FindPage({super.key});

  @override
  State<FindPage> createState() => _FindPageState();
}

class _FindPageState extends State<FindPage> {
  late final Future<List<dynamic>> _future;

  @override
  void initState() {
    super.initState();
    _future = Supabase.instance.client
        .from('movies')
        .select(); // 指定类型，增强可读性与安全性
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('发现'),
      ),
      body: FutureBuilder(
        future: _future,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(
              child: Text('加载失败：${snapshot.error}'),
            );
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('暂无电影数据'));
          }

          final movies = snapshot.data!;

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              final movie = movies[index];
              return ListTile(
                title: Text(movie['name'] ?? '无标题'),
                subtitle: SelectableText(movie['description'] ?? '无描述'),
              );
            },
          );
        },
      ),
    );
  }
}
