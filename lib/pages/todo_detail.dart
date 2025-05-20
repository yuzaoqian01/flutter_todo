import 'dart:developer' as developer;
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

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();

  @override
  void initState() {
    super.initState();
    developer.log('TodoEditPage initialized with todoId: ${widget.todoId}');
    if (widget.todoId != null) {
      _loadTodo(widget.todoId!);
    }
  }
    Future<void> _loadTodo(int todoId) async {
    developer.log('Loading todo with ID: $todoId');

    final res = await SharedPrefsUtil.getObjectList(
      'todo_list',
      (map) => Todo.fromJson(map),
    );

    setState(() {
      todos = res;
      todo = todos.firstWhere((element) => element.id == todoId);
      _titleController.text = todo.title;
      _descController.text = todo.description;
    });
  }
  Future<void> _saveTodo() async {
    final title = _titleController.text.trim();
    final desc = _descController.text.trim();

    if (title.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('标题不能为空')),
      );
      return;
    }

    if (desc.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('描述不能为空')),
      );
      return;
    }

    todo.title = title;
    todo.description = desc;

    todos = await SharedPrefsUtil.getObjectList(
      'todo_list',
      (map) => Todo.fromJson(map),
    );

    if (widget.todoId != null) {
      // 编辑模式
      final index = todos.indexWhere((t) => t.id == widget.todoId);
      if (index != -1) {
        todos[index] = todo;
      }
    } else {
      // 添加模式
      final maxId = todos.isEmpty ? 0 : todos.map((t) => t.id).reduce((a, b) => a > b ? a : b);
      todo.id = maxId + 1;
      todos.add(todo);
    }

    await SharedPrefsUtil.saveObjectList<Todo>(
      'todo_list',
      todos,
      (t) => t.toJson(),
    );

    if (!mounted) return;
    Navigator.of(context).pop('refresh');
  }
  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(todo.id == 0 ? '添加待办' : '编辑待办'),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveTodo,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
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
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: '待办标题',
                    prefixIcon: const Icon(Icons.title),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                TextField(
                  controller: _descController,
                  decoration: InputDecoration(
                    labelText: '待办描述',
                    prefixIcon: const Icon(Icons.description),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  maxLines: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
