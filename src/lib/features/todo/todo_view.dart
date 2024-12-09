import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/todo/todo_viewmodel.dart';
import 'package:my_app/features/todo/widgets/todo_input.dart';
import 'package:my_app/features/todo/widgets/todo_item.dart';

class TodoView extends StackedView<TodoViewModel> {
  const TodoView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TodoViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Column(
        children: [
          TodoInput(
            onSubmit: viewModel.addTodo,
          ),
          Expanded(
            child: ListView.builder(
              itemCount: viewModel.todos.length,
              itemBuilder: (context, index) {
                final todo = viewModel.todos[index];
                return TodoItem(
                  todo: todo,
                  onToggle: () => viewModel.toggleTodo(todo.id),
                  onTap: () => viewModel.showTodoOptions(todo),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  TodoViewModel viewModelBuilder(BuildContext context) => TodoViewModel(
        // These will be injected via the app.locator
        // ignore: undefined_identifier
        locator<TodoRepository>(),
        // ignore: undefined_identifier
        locator<DialogService>(),
        // ignore: undefined_identifier
        locator<BottomSheetService>(),
      );
}
