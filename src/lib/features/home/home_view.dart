import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../models/todo.dart';
import 'home_viewmodel.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: viewModel.todos.isEmpty
          ? const Center(
              child: Text('No todos yet. Add some!'),
            )
          : ListView.builder(
              itemCount: viewModel.todos.length,
              itemBuilder: (context, index) {
                final todo = viewModel.todos[index];
                return TodoCard(
                  todo: todo,
                  onToggle: () => viewModel.toggleTodoStatus(todo),
                  onEdit: () => viewModel.editTodo(todo),
                  onDelete: () => viewModel.deleteTodo(todo.id),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: viewModel.addTodo,
        child: const Icon(Icons.add),
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}

class TodoCard extends StatelessWidget {
  final Todo todo;
  final VoidCallback onToggle;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const TodoCard({
    Key? key,
    required this.todo,
    required this.onToggle,
    required this.onEdit,
    required this.onDelete,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (_) => onToggle(),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Text(todo.description),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.edit),
              onPressed: onEdit,
            ),
            IconButton(
              icon: const Icon(Icons.delete),
              onPressed: onDelete,
            ),
          ],
        ),
      ),
    );
  }
}
