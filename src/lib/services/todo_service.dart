import 'package:my_app/models/todo_model.dart';
import 'package:logger/logger.dart';

class TodoService {
  final Logger _logger = Logger();
  final List<TodoModel> _todos = [];

  List<TodoModel> get todos => List.unmodifiable(_todos);

  void addTodo(String title) {
    try {
      final todo = TodoModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        title: title,
        isCompleted: false,
        createdAt: DateTime.now(),
      );
      _todos.add(todo);
      _logger.i('Todo added: ${todo.title}');
    } catch (e) {
      _logger.e('Error adding todo: $e');
      rethrow;
    }
  }

  void toggleTodo(String id) {
    try {
      final index = _todos.indexWhere((todo) => todo.id == id);
      if (index != -1) {
        final todo = _todos[index];
        _todos[index] = todo.copyWith(isCompleted: !todo.isCompleted);
        _logger.i('Todo toggled: ${todo.title}');
      }
    } catch (e) {
      _logger.e('Error toggling todo: $e');
      rethrow;
    }
  }

  void deleteTodo(String id) {
    try {
      _todos.removeWhere((todo) => todo.id == id);
      _logger.i('Todo deleted: $id');
    } catch (e) {
      _logger.e('Error deleting todo: $e');
      rethrow;
    }
  }

  void updateTodo(String id, String title) {
    try {
      final index = _todos.indexWhere((todo) => todo.id == id);
      if (index != -1) {
        _todos[index] = _todos[index].copyWith(title: title);
        _logger.i('Todo updated: $id');
      }
    } catch (e) {
      _logger.e('Error updating todo: $e');
      rethrow;
    }
  }
}
