import 'package:flutter/material.dart';

class FormSubmitBtn extends StatelessWidget {
  final bool isUpdatePost;
  final Function() onPressed;

  const FormSubmitBtn({Key? key, required this.isUpdatePost, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: onPressed,
      icon: Icon(isUpdatePost ? Icons.edit : Icons.add),
      label: Text(isUpdatePost ? 'Update' : 'Add'),
    );
  }
}
