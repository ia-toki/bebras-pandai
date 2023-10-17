import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  CustomDatePicker(this.labelText, this.handleTextInput, this.validator);

  final String labelText;
  final void Function (String value)? handleTextInput;
  final String? Function(String?)? validator;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  final TextEditingController dateinput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 0.0),
        child: TextFormField(
          controller: dateinput,
          validator: widget.validator,
          style: TextStyle(fontSize: 12.0, color: Colors.black),
          decoration: InputDecoration(
            helperText: '',
            helperStyle: TextStyle(fontSize: 10),
            labelText: widget.labelText,
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
          readOnly: true,
          //set it true, so that user will not able to edit text
          onTap: () async {
            DateTime? pickedDate = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2101));

            if (pickedDate != null) {
              String formattedDate =
              DateFormat('dd MMM yyyy').format(pickedDate);
              widget.handleTextInput!(pickedDate.toIso8601String());
              setState(() {
                dateinput.text = formattedDate;
              });
            } else {
              print("Date is not selected");
            }
          },
          onChanged: (value) => widget.handleTextInput!(value),
        ),
      ),
    );
  }
}