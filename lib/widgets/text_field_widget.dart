import 'package:flutter/material.dart';

class TextFieldWidget extends StatelessWidget {
  final String label;
  final TextEditingController controller;
  final TextInputType type;

  const TextFieldWidget({
    super.key,
    required this.label,
    required this.controller,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: type,
      decoration: InputDecoration(
        label: Text(label),
        contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        border: OutlineInputBorder(),
      ),
    );
  }
}
