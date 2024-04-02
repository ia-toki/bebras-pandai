import 'package:flutter/material.dart';

class CustomTextFieldV2 extends StatelessWidget {
  const CustomTextFieldV2(
    this.labelText,
    this.handleTextInput,
    this.validator,
    this.initValue, {
    super.key,
  });

  final String labelText;
  final void Function(String value)? handleTextInput;
  final String? Function(String?)? validator;
  final String? initValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: TextFormField(
        onChanged: (value) => handleTextInput!(value),
        validator: validator,
        initialValue: initValue,
        style: const TextStyle(fontSize: 12),
        decoration: InputDecoration(
          helperText: '',
          helperStyle: const TextStyle(fontSize: 10),
          labelText: labelText,
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
        ),
      ),
    );
  }
}
