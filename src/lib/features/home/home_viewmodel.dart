import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/todo.dart';
import 'package:my_app/services/todo_service.dart';

class HomeViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();

  List<Todo> get todos => _todoService.getTodos();

  Future<void> addTodo() async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.todo,
      title: 'Add Todo',
    );

    if (response?.confirmed == true && response?.data != null) {
      _todoService.addTodo(response!.data);
      notifyListeners();
    }
  }

  Future<void> editTodo(Todo todo) async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.todo,
      title: 'Edit Todo',
      data: todo.title,
    );

    if (response?.confirmed == true && response?.data != null) {
      _todoService.updateTodo(todo.id, response!.data);
      notifyListeners();
    }
  }

  void toggleTodo(String id, bool isCompleted) {
    _todoService.toggleTodo(id, isCompleted);
    notifyListeners();
  }

  void deleteTodo(String id) {
    _todoService.deleteTodo(id);
    notifyListeners();
  }
}
