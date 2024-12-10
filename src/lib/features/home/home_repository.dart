import 'package:my_app/models/todo.dart';
import 'package:my_app/services/todo_service.dart';

class HomeRepository {
  final TodoService _todoService;

  HomeRepository(this._todoService);

  List<Todo> getTodos() {
    return _todoService.todos;
  }

  Future<void> addTodo(Todo todo) async {
    await _todoService.addTodo(todo);
  }

  Future<void> updateTodo(Todo todo) async {
    await _todoService.updateTodo(todo);
  }

  Future<void> deleteTodo(String id) async {
    await _todoService.deleteTodo(id);
  }

  Future<void> toggleTodoStatus(String id) async {
    await _todoService.toggleTodoStatus(id);
  }
}
