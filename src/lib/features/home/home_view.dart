import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/home/home_viewmodel.dart';
import 'package:my_app/features/home/widgets/add_todo_button.dart';
import 'package:my_app/features/home/widgets/todo_list.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({super.key});

  @override
  Widget builder(BuildContext context, HomeViewModel viewModel, Widget? child) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: TodoList(
        todos: viewModel.todos,
        onToggleTodo: viewModel.toggleTodo,
        onDeleteTodo: viewModel.deleteTodo,
        onEditTodo: viewModel.editTodo,
      ),
      floatingActionButton: AddTodoButton(
        onPressed: viewModel.addTodo,
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();
}
