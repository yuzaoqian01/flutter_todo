import 'package:flutter/material.dart';


import 'package:todo/pages/index_page.dart';
import 'package:todo/pages/find_page.dart';
import 'package:todo/pages/me_page.dart';

import 'package:todo/pages/field.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    themeMode: ThemeMode.dark,
    theme: ThemeData(
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: Colors.black,
        indicatorColor: Colors.white,
        labelTextStyle:  WidgetStatePropertyAll(
          TextStyle(
            color: Colors.red,
            fontSize: 13,
          ),
        ),
      ),
    ),
    routes: {
      '/field': (context) => const FieldPage(),
    },
    home: HomePage()
  );
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    Center(child: IndexPage()),
    Center(child: FindPage()),
    Center(child: MePage()),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: '发现'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
        ],
      ),
    );
  }
}
