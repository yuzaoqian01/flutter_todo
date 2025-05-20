import 'package:flutter/material.dart';

import 'package:todo/utils/shared_prefs_util.dart';
import 'package:todo/models/todo.dart';

class TodoEditPage extends StatefulWidget {
  const TodoEditPage({super.key, this.todoId});
  final int? todoId;

  @override
  State<TodoEditPage> createState() => _TodoEditPageState();
}

class _TodoEditPageState extends State<TodoEditPage> {
  Todo todo = Todo(id: 0, title: '', description: '', isCompleted: false);
  List<Todo> todos = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: todo.id == 0
            ? const Text('添加待办') 
            : const Text('编辑待办'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: () async {
              if (todo.title.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('标题不能为空'),
                  ),
                );
                return;
              }
              if (todo.description.isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('描述不能为空'),
                  ),
                );
                return;
              }

              todos = await SharedPrefsUtil.getObjectList(
                'todo_list',
                (map) => Todo.fromJson(map),
              );
              var todoId = todos.length + 1;
              todo.id = todoId;
              todos.add(todo);
              await SharedPrefsUtil.saveObjectList<Todo>(
                'todo_list',
                todos,
                (todo) => todo.toJson(),
              );
              if (!mounted) return;
              Navigator.of(context).pop('refresh');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 6,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                    labelText: '待办标题',
                    prefixIcon: const Icon(Icons.title),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onChanged: (value) {
                    setState(() {
                      todo.title = value;
                    });
                  },
                ),
                const SizedBox(height: 20),
                TextField(
                  decoration: InputDecoration(
                    labelText: '待办描述',
                    prefixIcon: const Icon(Icons.description),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  maxLines: 4,
                  onChanged: (value) {
                    setState(() {
                      todo.description = value;
                    });
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
