import 'package:flutter/material.dart';

class CustomInput extends StatelessWidget {
  final String label;
  final ValueChanged<String> onChanged;
  final bool obscureText;

  const CustomInput({
    super.key,
    required this.label,
    required this.onChanged,
    this.obscureText = false,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onChanged: onChanged,
      obscureText: obscureText,
      decoration: InputDecoration(
        labelText: label,
      ),
    );
  }
}
