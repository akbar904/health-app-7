// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// StackedDialogGenerator
// **************************************************************************

import 'package:stacked_services/stacked_services.dart';

import 'app.locator.dart';
import '../ui/dialogs/todo_confirmation/todo_confirmation_dialog.dart';

enum DialogType {
  todoConfirmation,
}

void setupDialogUi() {
  final dialogService = locator<DialogService>();

  final Map<DialogType, DialogBuilder> builders = {
    DialogType.todoConfirmation: (context, request, completer) =>
        TodoConfirmationDialog(request: request, completer: completer),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
