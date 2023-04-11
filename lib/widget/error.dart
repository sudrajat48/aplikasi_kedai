import 'package:flutter/material.dart';

class ErrorDialog extends StatelessWidget {
  final String? message;
  // ignore: use_key_in_widget_constructors
  const ErrorDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Text(message!),
      actions: [
        ElevatedButton(
          // ignore: sort_child_properties_last
          child: const Center(
            child: Text('Kamu Tidak Bisa Masuk'),
          ),
          style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ],
    );
  }
}
