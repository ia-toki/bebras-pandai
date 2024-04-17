import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class CustomDatePickerV2 extends StatefulWidget {
  const CustomDatePickerV2(
    this.labelText,
    this.handleTextInput,
    this.validator,
    this.initValue, {
    Key? key,
  }) : super(key: key);

  final String labelText;
  final void Function(String value)? handleTextInput;
  final String? Function(String?)? validator;
  final String? initValue;

  @override
  State<CustomDatePickerV2> createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePickerV2> {
  final TextEditingController dateinput = TextEditingController();

  @override
  void initState() {
    setState(() {
      dateinput.text = widget.initValue!;
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 70,
      child: Padding(
        padding: const EdgeInsets.symmetric(),
        child: TextFormField(
          controller: dateinput,
          validator: widget.validator,
          style: const TextStyle(fontSize: 15, color: Colors.black),
          decoration: InputDecoration(
            helperText: '',
            helperStyle: const TextStyle(fontSize: 10),
            // labelText: widget.labelText,
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
            suffixIcon: GestureDetector(
              onTap: () async {
                final pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2101),
                );

                if (pickedDate != null) {
                  final formattedDate =
                      DateFormat('yyyy-MM-dd').format(pickedDate);
                  widget.handleTextInput!(formattedDate);
                  setState(() {
                    dateinput.text = formattedDate;
                  });
                } else {
                  print('Date is not selected');
                }
              },
              child: const Icon(Icons.calendar_today),
            ),
          ),
          readOnly: true,
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
