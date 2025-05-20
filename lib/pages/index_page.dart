import 'package:flutter/material.dart';


import 'package:todo/pages/todo_detail.dart';
import 'package:todo/models/todo.dart';
import 'package:todo/utils/shared_prefs_util.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}



class _IndexPageState extends State<IndexPage> {
  
 
  Future getTodos() async {
    // Simulate fetching data from a database or API
    var res = await SharedPrefsUtil.getObjectList(
      "todo_list",
      (map) => Todo.fromJson(map),
    );
    setState(() {
      todos = res;
    });
  }

  List<Todo> todos = [];

  List<int> selectedItems = [];

  @override
  void initState() {
    super.initState();
    getTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('首页', style: TextStyle(color: Colors.black)),
        actions: [
          IconButton(
            icon: const Icon(Icons.delete, color: Colors.red),
            onPressed: () async{
              // Handle delete action
              await SharedPrefsUtil.removeKey('todo_list');
              getTodos();
            },
          ),
        ],
      ),
      body: todos.isEmpty? const Center(child: Text('暂无待办'))
      :ListView.builder(
        itemCount: todos.length,
        itemBuilder: (context, index) {
          var todo = todos[index];
          bool isSelected = selectedItems.contains(todo.id);
          return ListTile(
            title: Text(todo.title),
            subtitle: Text(todo.description),
            leading: Checkbox(value: isSelected, onChanged: (value) {
              setState(() {
                if (value == true) {
                  selectedItems.add(todo.id);
                } else {
                  selectedItems.remove(todo.id);
                }
              });
            }),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  padding: const EdgeInsets.only(right: 4),
                  icon: const Icon(Icons.edit, size: 15,),
                  splashRadius: 8,
                  onPressed: () {
                    // Handle edit action
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TodoEditPage(
                          todoId: todo.id, // Pass the todo ID or object here
                        ),
                      ),
                    );
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 15,),
                  color: Colors.red,
                  splashRadius: 8,
                  onPressed: () {
                    // Handle delete action
                  },
                ),
              ],
            ),
            onTap: () {
              // Handle item tap
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TodoEditPage(),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        highlightElevation: 10,
        onPressed:  () async {
          // Handle add action
          final result = await Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const TodoEditPage(),
            ),
          );
          if (result == 'refresh') {
            getTodos();
          }
        },
        child: const Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
    );
  }
}
