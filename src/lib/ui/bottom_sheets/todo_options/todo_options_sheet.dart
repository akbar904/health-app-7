import 'package:flutter/material.dart';
import 'package:stacked_services/stacked_services.dart';

class TodoOptionsSheet extends StatelessWidget {
  final SheetRequest request;
  final Function(SheetResponse) completer;

  const TodoOptionsSheet({
    Key? key,
    required this.request,
    required this.completer,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            request.title ?? 'Todo Options',
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            request.description ?? '',
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 16),
          ListTile(
            leading: const Icon(Icons.edit),
            title: const Text('Edit'),
            onTap: () =>
                completer(SheetResponse(confirmed: true, data: 'edit')),
          ),
          ListTile(
            leading: const Icon(Icons.check_circle),
            title: const Text('Toggle Completion'),
            onTap: () =>
                completer(SheetResponse(confirmed: true, data: 'toggle')),
          ),
          ListTile(
            leading: const Icon(Icons.delete, color: Colors.red),
            title: const Text('Delete', style: TextStyle(color: Colors.red)),
            onTap: () =>
                completer(SheetResponse(confirmed: true, data: 'delete')),
          ),
        ],
      ),
    );
  }
}
