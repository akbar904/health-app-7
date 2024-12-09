import 'package:flutter/material.dart';
import 'package:my_app/features/home/widgets/todo_item.dart';
import 'package:my_app/models/todo.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final Function(String) onToggleTodo;
  final Function(String) onDeleteTodo;

  const TodoList({
    required this.todos,
    required this.onToggleTodo,
    required this.onDeleteTodo,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: todos.length,
      separatorBuilder: (context, index) => const Divider(height: 1),
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItem(
          todo: todo,
          onToggle: () => onToggleTodo(todo.id),
          onDelete: () => onDeleteTodo(todo.id),
        );
      },
    );
  }
}
