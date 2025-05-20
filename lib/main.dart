import 'package:flutter/material.dart';


import 'package:todo/pages/index_page.dart';
import 'package:todo/pages/find_page.dart';
import 'package:todo/pages/me_page.dart';
import 'package:todo/pages/field.dart';
import 'package:todo/pages/todo_detail.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    themeMode: ThemeMode.light,
     theme: ThemeData(
      colorScheme: const ColorScheme.light(
        primary: Colors.black,
        secondary: Colors.teal,
      ),
      useMaterial3: true,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        titleTextStyle: TextStyle(
          fontSize: 16, // 👈 这里设置标题字体大小
          fontWeight: FontWeight.w500,
          color: Colors.black,
        ),
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: Colors.black,
        indicatorColor: Colors.white,
        labelTextStyle: WidgetStatePropertyAll(
          TextStyle(
            color: Colors.red,
            fontSize: 13,
          ),
        ),
      ),
    ),
    routes: {
      '/field': (context) => const FieldPage(),
      '/todoDetail/:id': (context) => const TodoEditPage(),
    },
    home: HomePage()
  );
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

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
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashFactory: NoSplash.splashFactory,
          highlightColor: Colors.transparent,
          splashColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          selectedItemColor: Colors.teal,
          onTap: (index) => setState(() => _currentIndex = index),
          items: const [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: '首页'),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: '发现'),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: '我的'),
          ],
        ),
      ),
    );
  }
}
