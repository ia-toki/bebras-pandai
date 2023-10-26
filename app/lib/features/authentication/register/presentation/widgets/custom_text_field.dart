import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  const CustomTextField(this.labelText, this.handleTextInput, this.validator, {super.key});

  final String labelText;
  final void Function (String value)? handleTextInput;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: TextFormField(
        onChanged: (value) => handleTextInput!(value),
        validator: validator,
        style: const TextStyle(fontSize: 12),
        decoration: InputDecoration(
          helperText: '',
          helperStyle: const TextStyle(fontSize: 10),
          labelText: labelText,
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
        ),
      ),
    );
  }
}