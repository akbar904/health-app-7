import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoDeleteDialogModel extends BaseViewModel {}

class TodoDeleteDialog extends StackedView<TodoDeleteDialogModel> {
  final DialogRequest request;
  final Function(DialogResponse) completer;

  const TodoDeleteDialog({
    required this.request,
    required this.completer,
    Key? key,
  }) : super(key: key);

  @override
  Widget builder(
    BuildContext context,
    TodoDeleteDialogModel viewModel,
    Widget? child,
  ) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      backgroundColor: Colors.white,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Delete Todo',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              request.description ??
                  'Are you sure you want to delete this todo?',
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                TextButton(
                  onPressed: () => completer(DialogResponse(confirmed: false)),
                  child: const Text('Cancel'),
                ),
                ElevatedButton(
                  onPressed: () => completer(DialogResponse(confirmed: true)),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Delete'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  TodoDeleteDialogModel viewModelBuilder(BuildContext context) =>
      TodoDeleteDialogModel();
}
