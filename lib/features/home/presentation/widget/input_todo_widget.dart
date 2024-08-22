import 'package:flutter/material.dart';

class InputWidget extends StatelessWidget {
  const InputWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const AlertDialog(
      title: Text('Hello World!'),
      actions: [
        Text('Hello World!'),
        Text('Hello World!'),
      ],
    );
  }
}
