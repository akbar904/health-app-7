import '../models/todo.dart';

class TodoService {
  final List<Todo> _todos = [];

  List<Todo> get todos => List.unmodifiable(_todos);

  void addTodo(Todo todo) {
    _todos.add(todo);
  }

  void updateTodo(Todo updatedTodo) {
    final index = _todos.indexWhere((todo) => todo.id == updatedTodo.id);
    if (index != -1) {
      _todos[index] = updatedTodo;
    }
  }

  void deleteTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
  }
}
