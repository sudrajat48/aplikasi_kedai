import 'package:aplikasi_kedai/widget/progress_bar.dart';
import 'package:flutter/material.dart';

class LoadingDialog extends StatelessWidget {
  final String? message;
  // ignore: use_key_in_widget_constructors
  const LoadingDialog({this.message});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      key: key,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircularProgress(),
          const SizedBox(
            height: 10,
          ),
          Text('${message!}, Tunggu Sebentar...'),
        ],
      ),
    );
  }
}
