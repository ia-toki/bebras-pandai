import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(
    this.handleTextInput,
    this.validator,
    this.initValue, {
    super.key,
  });

  final void Function(String value)? handleTextInput;
  final String? Function(String?)? validator;
  final String? initValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextFormField(
        onChanged: (value) => handleTextInput!(value),
        validator: validator,
        initialValue: initValue,
        style: const TextStyle(fontSize: 12),
        decoration: InputDecoration(
          helperText: '',
          helperStyle: const TextStyle(fontSize: 10),
          filled: true,
          fillColor: Colors.grey.shade200,
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
        ),
      ),
    );
  }
}
