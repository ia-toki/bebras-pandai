import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePicker extends StatefulWidget {
  const CustomDatePicker(
    this.labelText,
    this.handleTextInput,
    this.validator, {
    super.key,
  });

  final String labelText;
  final void Function(String value)? handleTextInput;
  final String? Function(String?)? validator;

  @override
  State<CustomDatePicker> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  final TextEditingController dateinput = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 60,
      child: Padding(
        // ignore: use_named_constants
        padding: const EdgeInsets.symmetric(),
        child: TextFormField(
          controller: dateinput,
          validator: widget.validator,
          style: const TextStyle(fontSize: 12, color: Colors.black),
          decoration: InputDecoration(
            helperText: '',
            helperStyle: const TextStyle(fontSize: 10),
            labelText: widget.labelText,
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
          readOnly: true,
          //set it true, so that user will not able to edit text
          onTap: () async {
            final pickedDate = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(1900),
              lastDate: DateTime(2101),
            );

            if (pickedDate != null) {
              final formattedDate = DateFormat('yyyy-MM-dd').format(pickedDate);
              widget.handleTextInput!(formattedDate);
              setState(() {
                dateinput.text = formattedDate;
              });
            } else {
              print('Date is not selected');
            }
          },
          onChanged: (value) => widget.handleTextInput!(value),
        ),
      ),
    );
  }
}
