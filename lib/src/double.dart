import 'package:flutter/material.dart';

class DoubleEditModal extends StatefulWidget {
  final double initialValue;
  final Widget? trailing;
  final Widget? title;

  const DoubleEditModal(
      {super.key, this.initialValue = 0, this.trailing, this.title});

  @override
  State<DoubleEditModal> createState() => _DoubleEditModalState();
}

class _DoubleEditModalState extends State<DoubleEditModal> {
  late final controller = TextEditingController(text: "${widget.initialValue}");
  late double currentValue = widget.initialValue;
  late final focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    focusNode.requestFocus();
  }

  void onEditingComplete() {
    try {
      currentValue = double.parse(controller.text);
    } on FormatException {
      controller.text = "${widget.initialValue}";
    }
  }

  void onSave() {
    onEditingComplete();
    Navigator.of(context).pop(currentValue);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        title: widget.title ?? const Text("Set Value"),
        content: Row(children: [
          Expanded(
            child: TextField(
              controller: controller,
              keyboardType:
                  const TextInputType.numberWithOptions(decimal: true),
              focusNode: focusNode,
              onEditingComplete: onEditingComplete,
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
