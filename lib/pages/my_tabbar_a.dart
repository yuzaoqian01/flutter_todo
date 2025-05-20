import 'package:flutter/material.dart';

// 自定义tabbar组件

class TabbarA extends StatefulWidget {
  const TabbarA({super.key});

  static const List<Tab> tabs = <Tab>[Tab(text: 'Zeroth'), Tab(text: 'First'), Tab(text: 'Second')];

  @override
  State<TabbarA> createState() => _TabbarAState();
}

class _TabbarAState extends State<TabbarA> {



  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}