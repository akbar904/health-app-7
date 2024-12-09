import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/home/home_viewmodel.dart';
import 'package:my_app/features/home/widgets/todo_input.dart';
import 'package:my_app/features/home/widgets/todo_list.dart';

class HomeView extends StackedView<HomeViewModel> {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    HomeViewModel viewModel,
    Widget? child,
  ) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
      ),
      body: Column(
        children: [
          TodoInput(
            onSubmit: viewModel.addTodo,
            isLoading: viewModel.isBusy,
          ),
          const Divider(height: 1),
          Expanded(
            child: viewModel.isBusy
                ? const Center(child: CircularProgressIndicator())
                : TodoList(
                    todos: viewModel.todos,
                    onToggleTodo: viewModel.toggleTodo,
                    onDeleteTodo: viewModel.deleteTodo,
                  ),
          ),
        ],
      ),
    );
  }

  @override
  HomeViewModel viewModelBuilder(BuildContext context) => HomeViewModel();

  @override
  void onViewModelReady(HomeViewModel viewModel) => viewModel.initialize();
}
