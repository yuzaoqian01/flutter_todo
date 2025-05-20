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
  // Function to get the list of todos from SharedPreferences 
  Future getTodos() async {
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
            title: Text(todo.title, style: TextStyle(
              color: todo.isCompleted?Colors.red:Colors.blue,
              decoration: todo.isCompleted? TextDecoration.lineThrough:TextDecoration.none  
            ),),
            subtitle: Text(todo.description,
              style: TextStyle(
              color: todo.isCompleted?Colors.red:Colors.blue,
              decoration: todo.isCompleted? TextDecoration.lineThrough:TextDecoration.none
              ),
            ),
            leading: Checkbox(value: isSelected, onChanged: (value) {
              setState(() {
                if (value == true) {
                  selectedItems.add(todo.id);
                  todos[index].isCompleted = true;
                  SharedPrefsUtil.saveObjectList(
                    "todo_list",
                    todos,
                    (todo) => todo.toJson(),
                  );
                } else {
                  selectedItems.remove(todo.id);
                  todos[index].isCompleted = false;
                  SharedPrefsUtil.saveObjectList(
                    "todo_list",
                    todos,
                    (todo) => todo.toJson(),
                  );
                }
                setState(() {
                  todos[index].isCompleted = value!;
                });
              });
            }),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                IconButton(
                  padding: const EdgeInsets.only(right: 4),
                  icon: const Icon(Icons.edit, size: 15,),
                  splashRadius: 8,
                  onPressed: () async{
                    // Handle edit action
                   final result = await Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => TodoEditPage(
                          todoId: todo.id, // Pass the todo ID or object here
                        ),
                      ),
                    );
                    if (result == 'refresh') {
                      getTodos();
                    }
                  },
                ),
                IconButton(
                  icon: const Icon(Icons.delete, size: 15,),
                  color: Colors.red,
                  splashRadius: 8,
                  onPressed: () async {
                    // Handle delete action
                    
                    setState(() {
                      todos.removeAt(index);
                      SharedPrefsUtil.saveObjectList(
                        "todo_list",
                        todos,
                        (todo) => todo.toJson(),
                      );
                    });

                    
                    
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: const Text('删除成功'),
                        action: SnackBarAction(
                          label: '撤销',
                          onPressed: () {
                            // Handle undo action
                            setState(() {
                              todos.insert(index, todo);
                              SharedPrefsUtil.saveObjectList(
                                "todo_list",
                                todos,
                                (todo) => todo.toJson(),
                              );
                            });
                          },
                        ),
                      ),
                    );
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
