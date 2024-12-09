import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:my_app/features/home/home_viewmodel.dart';
import 'package:my_app/features/home/widgets/todo_input.dart';
import 'package:my_app/features/home/widgets/todo_item.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text('Todo App'),
        ),
        body: Column(
          children: [
            TodoInput(
              controller: model.todoController,
              onSubmit: model.addTodo,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: model.todos.length,
                itemBuilder: (context, index) {
                  final todo = model.todos[index];
                  return TodoItem(
                    todo: todo,
                    onToggle: model.toggleTodo,
                    onDelete: model.deleteTodo,
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
