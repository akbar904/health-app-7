import 'package:stacked/stacked.dart';
import 'package:my_app/models/todo.dart';
import 'package:my_app/features/todo/todo_repository.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoViewModel extends BaseViewModel {
  final TodoRepository _todoRepository;
  final DialogService _dialogService;
  final BottomSheetService _bottomSheetService;

  TodoViewModel(
    this._todoRepository,
    this._dialogService,
    this._bottomSheetService,
  );

  List<Todo> get todos => _todoRepository.getAllTodos();
  List<Todo> get activeTodos => _todoRepository.getActiveTodos();
  List<Todo> get completedTodos => _todoRepository.getCompletedTodos();

  void addTodo(String title) {
    try {
      _todoRepository.addTodo(title);
      notifyListeners();
    } catch (e) {
      _dialogService.showDialog(
        title: 'Error',
        description: e.toString(),
      );
    }
  }

  Future<void> toggleTodo(String id) async {
    _todoRepository.toggleTodo(id);
    notifyListeners();
  }

  Future<void> deleteTodo(String id) async {
    final response = await _dialogService.showDialog(
      title: 'Delete Todo',
      description: 'Are you sure you want to delete this todo?',
      buttonTitle: 'Delete',
      cancelTitle: 'Cancel',
    );

    if (response?.confirmed ?? false) {
      _todoRepository.deleteTodo(id);
      notifyListeners();
    }
  }

  Future<void> editTodo(String id, String currentTitle) async {
    final response = await _dialogService.showDialog(
      title: 'Edit Todo',
      description: 'Enter new title:',
      buttonTitle: 'Save',
      cancelTitle: 'Cancel',
    );

    if (response?.confirmed ?? false) {
      try {
        _todoRepository.editTodo(id, response?.data ?? '');
        notifyListeners();
      } catch (e) {
        _dialogService.showDialog(
          title: 'Error',
          description: e.toString(),
        );
      }
    }
  }

  Future<void> showTodoOptions(Todo todo) async {
    final response = await _bottomSheetService.showBottomSheet(
      title: 'Todo Options',
      description: todo.title,
    );

    if (response?.confirmed ?? false) {
      switch (response?.data) {
        case 'edit':
          await editTodo(todo.id, todo.title);
          break;
        case 'delete':
          await deleteTodo(todo.id);
          break;
        case 'toggle':
          await toggleTodo(todo.id);
          break;
      }
    }
  }
}
