import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/ui/views/todo/todo_viewmodel.dart';
import 'package:my_app/ui/views/todo/widgets/todo_input.dart';
import 'package:my_app/ui/views/todo/widgets/todo_item.dart';

class TodoView extends StatelessWidget {
  const TodoView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<TodoViewModel>.reactive(
      viewModelBuilder: () => TodoViewModel(),
      builder: (context, viewModel, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Todo App'),
          actions: [
            IconButton(
              icon: const Icon(Icons.file_upload),
              onPressed: viewModel.exportTodos,
            ),
            IconButton(
              icon: const Icon(Icons.file_download),
              onPressed: viewModel.importTodos,
            ),
          ],
        ),
        body: Column(
          children: [
            TodoInput(
              onSubmit: viewModel.addTodo,
            ),
            const Divider(),
            Expanded(
              child: ListView.builder(
                itemCount: viewModel.todos.length,
                itemBuilder: (context, index) {
                  final todo = viewModel.todos[index];
                  return TodoItem(
                    todo: todo,
                    onToggle: () => viewModel.toggleTodo(todo.id),
                    onDelete: () => viewModel.deleteTodo(todo.id),
                    onEdit: () => viewModel.showEditDialog(todo),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
