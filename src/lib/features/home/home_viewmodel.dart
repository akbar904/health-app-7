import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:my_app/app/app.locator.dart';
import 'package:my_app/models/todo.dart';
import 'package:my_app/services/todo_service.dart';

class HomeViewModel extends BaseViewModel {
  final _todoService = locator<TodoService>();
  final _dialogService = locator<DialogService>();

  List<Todo> _todos = [];
  List<Todo> get todos => _todos;

  Future<void> initialize() async {
    await loadTodos();
  }

  Future<void> loadTodos() async {
    setBusy(true);
    _todos = await _todoService.getTodos();
    setBusy(false);
    notifyListeners();
  }

  Future<void> addTodo(String title) async {
    if (title.trim().isEmpty) return;

    setBusy(true);
    await _todoService.addTodo(title);
    await loadTodos();
    setBusy(false);
  }

  Future<void> toggleTodo(String id) async {
    setBusy(true);
    await _todoService.toggleTodo(id);
    await loadTodos();
    setBusy(false);
  }

  Future<void> deleteTodo(String id) async {
    final response = await _dialogService.showCustomDialog(
      variant: 'todoDelete',
      description: 'Are you sure you want to delete this todo?',
    );

    if (response?.confirmed ?? false) {
      setBusy(true);
      await _todoService.deleteTodo(id);
      await loadTodos();
      setBusy(false);
    }
  }
}
