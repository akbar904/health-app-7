import 'package:flutter/material.dart';
import 'package:my_app/features/home/widgets/todo_item.dart';
import 'package:my_app/models/todo.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;
  final Function(String, bool) onToggleTodo;
  final Function(String) onDeleteTodo;
  final Function(Todo) onEditTodo;

  const TodoList({
    required this.todos,
    required this.onToggleTodo,
    required this.onDeleteTodo,
    required this.onEditTodo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return Center(
        child: Text(
          'No todos yet',
          style: Theme.of(context).textTheme.bodyLarge,
        ),
      );
    }

    return ListView.builder(
      itemCount: todos.length,
      itemBuilder: (context, index) {
        final todo = todos[index];
        return TodoItem(
          todo: todo,
          onToggle: (bool? value) {
            onToggleTodo(todo.id, value ?? false);
          },
          onDelete: () => onDeleteTodo(todo.id),
          onEdit: () => onEditTodo(todo),
        );
      },
    );
  }
}
