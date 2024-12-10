import 'package:flutter/material.dart';
import 'package:my_app/models/todo.dart';
import 'package:intl/intl.dart';

class TodoItem extends StatelessWidget {
  final Todo todo;
  final Function(String) onToggle;
  final Function(Todo) onTodoTap;

  const TodoItem({
    required this.todo,
    required this.onToggle,
    required this.onTodoTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: ListTile(
        onTap: () => onTodoTap(todo),
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (_) => onToggle(todo.id),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(todo.description),
            const SizedBox(height: 4),
            Text(
              'Created: ${DateFormat.yMMMd().format(todo.createdAt)}',
              style: Theme.of(context).textTheme.bodySmall,
            ),
            if (todo.completedAt != null)
              Text(
                'Completed: ${DateFormat.yMMMd().format(todo.completedAt!)}',
                style: Theme.of(context).textTheme.bodySmall,
              ),
          ],
        ),
        isThreeLine: true,
      ),
    );
  }
}
