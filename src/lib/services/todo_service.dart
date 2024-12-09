import 'package:my_app/models/todo.dart';

class TodoService {
  final List<Todo> _todos = [];

  List<Todo> getTodos() => List.unmodifiable(_todos);

  void addTodo(String title) {
    final todo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      isCompleted: false,
      createdAt: DateTime.now(),
    );
    _todos.add(todo);
  }

  void toggleTodo(String id, bool isCompleted) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index] = _todos[index].copyWith(isCompleted: isCompleted);
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
  }

  void updateTodo(String id, String title) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index] = _todos[index].copyWith(title: title);
    }
  }
}
