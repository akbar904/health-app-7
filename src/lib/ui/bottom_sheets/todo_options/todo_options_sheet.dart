import 'package:flutter/material.dart';
import 'package:my_app/models/todo.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoOptionsSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const TodoOptionsSheet({
    required this.request,
    required this.completer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final todo = request.data as Todo;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(16),
          topRight: Radius.circular(16),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'Todo Options',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: Icon(
              todo.isCompleted ? Icons.refresh : Icons.check,
              color: Colors.blue,
            ),
            title: Text(
              todo.isCompleted ? 'Mark as Pending' : 'Mark as Complete',
            ),
            onTap: () => completer(SheetResponse(data: 'toggle')),
          ),
          ListTile(
            leading: const Icon(
              Icons.delete,
              color: Colors.red,
            ),
            title: const Text('Delete'),
            onTap: () => completer(SheetResponse(data: 'delete')),
          ),
          ListTile(
            leading: const Icon(Icons.close),
            title: const Text('Cancel'),
            onTap: () => completer(SheetResponse(confirmed: false)),
          ),
        ],
      ),
    );
  }
}
