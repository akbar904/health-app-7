import 'dart:convert';
import 'package:my_app/models/todo.dart';
import 'package:flutter/foundation.dart';

class TodoService {
  final List<Todo> _todos = [];

  List<Todo> get todos => List.unmodifiable(_todos);

  Future<void> addTodo(Todo todo) async {
    try {
      _todos.add(todo);
      await _persistTodos();
    } catch (e) {
      debugPrint('Error adding todo: $e');
      rethrow;
    }
  }

  Future<void> updateTodo(Todo todo) async {
    try {
      final index = _todos.indexWhere((t) => t.id == todo.id);
      if (index != -1) {
        _todos[index] = todo;
        await _persistTodos();
      }
    } catch (e) {
      debugPrint('Error updating todo: $e');
      rethrow;
    }
  }

  Future<void> deleteTodo(String id) async {
    try {
      _todos.removeWhere((todo) => todo.id == id);
      await _persistTodos();
    } catch (e) {
      debugPrint('Error deleting todo: $e');
      rethrow;
    }
  }

  Future<void> toggleTodoStatus(String id) async {
    try {
      final index = _todos.indexWhere((t) => t.id == id);
      if (index != -1) {
        final todo = _todos[index];
        _todos[index] = todo.copyWith(
          isCompleted: !todo.isCompleted,
          completedAt: !todo.isCompleted ? DateTime.now() : null,
        );
        await _persistTodos();
      }
    } catch (e) {
      debugPrint('Error toggling todo status: $e');
      rethrow;
    }
  }

  Future<void> _persistTodos() async {
    // In a real app, this would persist to local storage or backend
    final todosJson = _todos.map((todo) => todo.toJson()).toList();
    debugPrint('Persisting todos: ${json.encode(todosJson)}');
  }
}
