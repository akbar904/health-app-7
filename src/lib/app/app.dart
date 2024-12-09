import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';
import '../features/home/home_view.dart';
import '../features/startup/startup_view.dart';
import '../services/todo_service.dart';
import '../ui/dialogs/add_todo/add_todo_dialog.dart';
import '../ui/dialogs/edit_todo/edit_todo_dialog.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: HomeView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: TodoService),
  ],
  dialogs: [
    StackedDialog(classType: AddTodoDialog),
    StackedDialog(classType: EditTodoDialog),
  ],
)
class App {}
