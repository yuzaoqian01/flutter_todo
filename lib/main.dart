import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';


import 'package:todo/pages/index_page.dart';
import 'package:todo/pages/find_page.dart';
import 'package:todo/pages/me_page.dart';
import 'package:todo/pages/field.dart';
import 'package:todo/pages/todo_detail.dart';
import 'package:todo/pages/local_auth_page.dart';
import 'package:todo/pages/file_page.dart';
import 'package:todo/pages/version_page.dart';
import 'package:todo/pages/lang_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://qbphwnrkbrgabxtejstl.supabase.co',
    anonKey: 'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6InFicGh3bnJrYnJnYWJ4dGVqc3RsIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MzYzNDIwNDUsImV4cCI6MjA1MTkxODA0NX0._dN7wR7Tma-YW2Mq_Q9xUMpX2jGmUf64ihdt_CQLwRU',
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    localizationsDelegates: [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: [
      Locale('en'), // English
      Locale('es'), // Spanish
    ],
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
      '/local_auth': (context) => const LocalAuthPage(),
      '/file': (context) => const FilePage(),
      '/version': (context) => const VersionPage(),
      '/lang': (context) => const LangePage(),
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
