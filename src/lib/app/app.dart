import 'package:my_app/features/home/home_view.dart';
import 'package:my_app/features/startup/startup_view.dart';
import 'package:my_app/features/todo/todo_view.dart';
import 'package:my_app/services/todo_service.dart';
import 'package:my_app/features/todo/todo_repository.dart';
import 'package:my_app/ui/bottom_sheets/todo_options/todo_options_sheet.dart';
import 'package:my_app/ui/dialogs/todo_confirmation/todo_confirmation_dialog.dart';
import 'package:stacked/stacked_annotations.dart';
import 'package:stacked_services/stacked_services.dart';

@StackedApp(
  routes: [
    MaterialRoute(page: StartupView, initial: true),
    MaterialRoute(page: HomeView),
    MaterialRoute(page: TodoView),
  ],
  dependencies: [
    LazySingleton(classType: NavigationService),
    LazySingleton(classType: DialogService),
    LazySingleton(classType: BottomSheetService),
    LazySingleton(classType: TodoService),
    LazySingleton(
      classType: TodoRepository,
      dependencies: [DependencyType(TodoService)],
    ),
  ],
  bottomsheets: [
    StackedBottomsheet(classType: TodoOptionsSheet),
  ],
  dialogs: [
    StackedDialog(classType: TodoConfirmationDialog),
  ],
)
class App {}
