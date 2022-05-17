import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class NextPageButton extends StatelessWidget {
  const NextPageButton({required this.onPressed, Key? key}) : super(key: key);
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(child: Icon(Icons.done), onPressed: onPressed);
  }
}
