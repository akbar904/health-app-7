import 'package:flutter/material.dart';

class TodoInput extends StatefulWidget {
  final Function(String) onSubmit;
  final bool isLoading;

  const TodoInput({
    required this.onSubmit,
    this.isLoading = false,
    Key? key,
  }) : super(key: key);

  @override
  State<TodoInput> createState() => _TodoInputState();
}

class _TodoInputState extends State<TodoInput> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleSubmit() {
    final text = _controller.text.trim();
    if (text.isNotEmpty) {
      widget.onSubmit(text);
      _controller.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: _controller,
              decoration: const InputDecoration(
                hintText: 'Add a new todo...',
                border: OutlineInputBorder(),
              ),
              enabled: !widget.isLoading,
              onSubmitted: (_) => _handleSubmit(),
            ),
          ),
          const SizedBox(width: 16),
          ElevatedButton(
            onPressed: widget.isLoading ? null : _handleSubmit,
            child: widget.isLoading
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  )
                : const Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
