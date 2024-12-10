import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/home/home_viewmodel.dart';
import 'package:my_app/features/home/widgets/todo_list.dart';
import 'package:my_app/features/home/widgets/todo_input.dart';
import 'package:my_app/utils/todo_status.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        actions: [
          PopupMenuButton<TodoStatus>(
            onSelected: viewModel.setFilter,
            itemBuilder: (context) => TodoStatus.values
                .map(
                  (status) => PopupMenuItem(
                    value: status,
                    child: Text(status.displayName),
                  ),
                )
                .toList(),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Text(viewModel.currentFilter.displayName),
                  const Icon(Icons.arrow_drop_down),
                ],
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          TodoInput(
            onSubmit: viewModel.addTodo,
          ),
          Expanded(
            child: TodoList(
              todos: viewModel.filteredTodos,
              onToggle: viewModel.toggleTodoStatus,
              onTodoTap: viewModel.showTodoOptions,
            ),
          ),
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel(
        homeRepository,
        dialogService,
        bottomSheetService,
      );
}
