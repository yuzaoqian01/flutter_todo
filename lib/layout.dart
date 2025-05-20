import 'package:flutter/material.dart';

import 'package:todo/pages/my_tabbar.dart';
import 'package:todo/pages/my_back.dart';
import 'package:todo/pages/todo.dart';



class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Layout Demo'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          const Text('Tabbar'),
          Row(
            children: [
              ElevatedButton(
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyTabbar()));
                }, 
                child: Text('基本的tabbar例子')
              ),
            ],
          ),
          ElevatedButton(
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> const MyBackPage()));
            }, 
            child: Text('pop')
            ),
            ElevatedButton(
              onPressed: () {
                final List<Todo> todos = List.generate(20, (i)=>Todo('title$i', 'description$i'));
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const TodosScreen(todos: todos,),
                  ),
                );
              },
              child: Text('todos'),
            )
          ],
        ),
      )
    );
  }
}

