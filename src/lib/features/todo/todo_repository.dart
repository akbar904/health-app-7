import 'package:my_app/models/todo.dart';
import 'package:my_app/services/todo_service.dart';

class TodoRepository {
  final TodoService _todoService;

  TodoRepository(this._todoService);

  List<Todo> getAllTodos() => _todoService.todos;

  void addTodo(String title) {
    if (title.trim().isEmpty) {
      throw Exception('Todo title cannot be empty');
    }
    _todoService.addTodo(title);
  }

  void toggleTodo(String id) {
    _todoService.toggleTodo(id);
  }

  void deleteTodo(String id) {
    _todoService.deleteTodo(id);
  }

  void editTodo(String id, String newTitle) {
    if (newTitle.trim().isEmpty) {
      throw Exception('Todo title cannot be empty');
    }
    _todoService.editTodo(id, newTitle);
  }

  List<Todo> getCompletedTodos() {
    return _todoService.filterTodos((todo) => todo.isCompleted);
  }

  List<Todo> getActiveTodos() {
    return _todoService.filterTodos((todo) => !todo.isCompleted);
  }
}
