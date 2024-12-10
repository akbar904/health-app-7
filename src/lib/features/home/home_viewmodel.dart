import 'package:my_app/models/todo.dart';
import 'package:my_app/utils/todo_status.dart';
import 'package:my_app/features/home/home_repository.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends BaseViewModel {
  final HomeRepository _repository;
  final DialogService _dialogService;
  final BottomSheetService _bottomSheetService;

  HomeViewModel(
    this._repository,
    this._dialogService,
    this._bottomSheetService,
  );

  List<Todo> get todos => _repository.getTodos();
  TodoStatus _currentFilter = TodoStatus.all;
  TodoStatus get currentFilter => _currentFilter;

  List<Todo> get filteredTodos {
    switch (_currentFilter) {
      case TodoStatus.pending:
        return todos.where((todo) => !todo.isCompleted).toList();
      case TodoStatus.completed:
        return todos.where((todo) => todo.isCompleted).toList();
      case TodoStatus.all:
        return todos;
    }
  }

  void setFilter(TodoStatus filter) {
    _currentFilter = filter;
    notifyListeners();
  }

  Future<void> addTodo(String title, String description) async {
    if (title.isEmpty) return;

    final todo = Todo(
      id: DateTime.now().millisecondsSinceEpoch.toString(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );

    await runBusyFuture(_repository.addTodo(todo));
  }

  Future<void> toggleTodoStatus(String id) async {
    await runBusyFuture(_repository.toggleTodoStatus(id));
  }

  Future<void> deleteTodo(String id) async {
    final response = await _dialogService.showConfirmationDialog(
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
      confirmationTitle: 'Delete',
      cancelTitle: 'Cancel',
    );

    if (response?.confirmed ?? false) {
      await runBusyFuture(_repository.deleteTodo(id));
    }
  }

  Future<void> showTodoOptions(Todo todo) async {
    final response = await _bottomSheetService.showCustomSheet(
      variant: 'todoOptions',
      data: todo,
    );

    if (response?.data != null) {
      switch (response?.data as String) {
        case 'delete':
          await deleteTodo(todo.id);
          break;
        case 'toggle':
          await toggleTodoStatus(todo.id);
          break;
      }
    }
  }
}
