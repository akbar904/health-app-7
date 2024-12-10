import 'package:flutter/material.dart';
import 'package:my_app/models/todo.dart';
import 'package:my_app/features/home/widgets/todo_item.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final Function(String) onToggle;
  final Function(Todo) onTodoTap;

  const TodoList({
    required this.todos,
    required this.onToggle,
    required this.onTodoTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return const Center(
        child: Text('No todos yet. Add one to get started!'),
      );
    }

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItem(
          todo: todo,
          onToggle: onToggle,
          onTodoTap: onTodoTap,
        );
      },
    );
  }
}
