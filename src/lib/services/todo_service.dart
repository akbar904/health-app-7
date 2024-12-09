import 'package:my_app/models/todo.dart';

class TodoService {
  final List<Todo> _todos = [];

  Future<List<Todo>> getTodos() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return _todos;
  }

  Future<void> addTodo(String title) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _todos.add(
      Todo(
        id: DateTime.now().toIso8601String(),
        title: title,
        createdAt: DateTime.now(),
      ),
    );
  }

  Future<void> toggleTodo(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    final todoIndex = _todos.indexWhere((todo) => todo.id == id);
    if (todoIndex != -1) {
      _todos[todoIndex] = _todos[todoIndex].copyWith(
        completed: !_todos[todoIndex].completed,
      );
    }
  }

  Future<void> deleteTodo(String id) async {
    await Future.delayed(const Duration(milliseconds: 500));
    _todos.removeWhere((todo) => todo.id == id);
  }
}
