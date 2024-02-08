import 'package:flutter/material.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String contentText;


  const CustomAlertDialog({super.key, required this.title, required this.contentText});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text('Error ocurred'),
      content: Text(contentText),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('OK'),
        )
      ],
    );
  }
}
