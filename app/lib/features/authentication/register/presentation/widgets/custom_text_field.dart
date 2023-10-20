import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField(this.labelText, this.handleTextInput, this.validator);

  final String labelText;
  final void Function (String value)? handleTextInput;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      child: TextFormField(
        onChanged: (value) => handleTextInput!(value),
        validator: validator,
        style: TextStyle(fontSize: 12.0),
        decoration: InputDecoration(
          helperText: '',
          helperStyle: TextStyle(fontSize: 10),
          labelText: labelText,
          filled: true,
          fillColor: Colors.grey.shade200,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.grey.shade200),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(color: Colors.grey.shade400),
          ),
        ),
      ),
    );
  }
}