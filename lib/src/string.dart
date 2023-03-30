import 'package:flutter/material.dart';

class StringEditModal extends StatefulWidget {
  final String initialValue;
  final Widget? trailing;
  final Widget? title;

  const StringEditModal(
      {super.key, this.initialValue = "", this.trailing, this.title});

  @override
  State<StringEditModal> createState() => _StringEditModalState();
}

class _StringEditModalState extends State<StringEditModal> {
  late final controller = TextEditingController(text: widget.initialValue);
  late final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.requestFocus();
  }

  void onSave() {
    Navigator.of(context).pop(controller.text);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: widget.title ?? const Text("Set Value"),
        content: Row(children: [
          Expanded(
            child: TextField(
              controller: controller,
              focusNode: focusNode,
              onSubmitted: (_) => onSave(),
            ),
          ),
          if (widget.trailing != null) widget.trailing!,
        ]),
        actions: [
          OutlinedButton(
              onPressed: () => Navigator.of(context).pop(null),
              child: const Text("Cancel")),
          ElevatedButton(onPressed: onSave, child: const Text("Save")),
        ]);
  }
}
