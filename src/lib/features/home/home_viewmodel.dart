import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../../models/todo.dart';
import '../../services/todo_service.dart';

class HomeViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();

  List<Todo> get todos => _todoService.todos;

  Future<void> addTodo() async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.addTodo,
    );

    if (response?.confirmed ?? false) {
      final data = response!.data as Map<String, String>;
      final todo = Todo(
        id: DateTime.now().toString(),
        title: data['title']!,
        description: data['description'] ?? '',
        isCompleted: false,
      );
      _todoService.addTodo(todo);
      notifyListeners();
    }
  }

  Future<void> editTodo(Todo todo) async {
    final response = await _dialogService.showCustomDialog(
      variant: DialogType.editTodo,
      data: todo,
    );

    if (response?.confirmed ?? false) {
      final data = response!.data as Map<String, String>;
      final updatedTodo = todo.copyWith(
        title: data['title']!,
        description: data['description'] ?? '',
      );
      _todoService.updateTodo(updatedTodo);
      notifyListeners();
    }
  }

  void toggleTodoStatus(Todo todo) {
    final updatedTodo = todo.copyWith(isCompleted: !todo.isCompleted);
    _todoService.updateTodo(updatedTodo);
    notifyListeners();
  }

  void deleteTodo(String id) {
    _todoService.deleteTodo(id);
    notifyListeners();
  }
}
