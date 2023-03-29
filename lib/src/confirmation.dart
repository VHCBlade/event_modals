import 'package:flutter/material.dart';

class ConfirmationDialog extends StatelessWidget {
  final Widget title;
  final Widget? content;
  const ConfirmationDialog({super.key, required this.title, this.content});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: title,
      content: content,
      actions: [
        OutlinedButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text("Cancel")),
        ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            child: const Text("Confirm"))
      ],
    );
  }
}
