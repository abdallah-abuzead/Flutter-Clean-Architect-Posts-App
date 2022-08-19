import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String name;
  final TextEditingController controller;
  final bool multiLine;

  const TextFormFieldWidget({
    Key? key,
    required this.controller,
    required this.name,
    this.multiLine = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
      child: TextFormField(
        controller: controller,
        minLines: multiLine ? 6 : 1,
        maxLines: multiLine ? 6 : 1,
        validator: (val) => val!.isEmpty ? "$name can't be empty." : null,
        decoration: InputDecoration(hintText: name),
      ),
    );
  }
}
