import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/services/todo_service.dart';
import 'package:my_app/models/todo_model.dart';

class HomeViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();
  final todoController = TextEditingController();

  List<TodoModel> get todos => _todoService.todos;

  void addTodo() {
    if (todoController.text.trim().isNotEmpty) {
      _todoService.addTodo(todoController.text.trim());
      todoController.clear();
      notifyListeners();
    }
  }

  void toggleTodo(String id) {
    _todoService.toggleTodo(id);
    notifyListeners();
  }

  Future<void> deleteTodo(String id) async {
    final response = await _dialogService.showDialog(
      dialogData: DialogData(
        title: 'Delete Todo',
        description: 'Are you sure you want to delete this todo?',
      ),
    );

    if (response?.confirmed ?? false) {
      _todoService.deleteTodo(id);
      notifyListeners();
    }
  }

  @override
  void dispose() {
    todoController.dispose();
    super.dispose();
  }
}
