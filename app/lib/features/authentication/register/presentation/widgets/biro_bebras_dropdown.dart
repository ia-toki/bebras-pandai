import 'package:bebras_pandai/core/constants/bebrasBiroDropdown.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class BiroBebrasDropdown extends StatelessWidget {
  BiroBebrasDropdown(this.labelText, this.handleTextInput, this.validator);

  final String labelText;
  final void Function(String value)? handleTextInput;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 63.0,
      child: DropdownSearch<String>(
        validator: validator,
        popupProps: PopupProps.menu(
          showSearchBox: true,
        ),
        items: bebrasBiroList,
        dropdownDecoratorProps: DropDownDecoratorProps(
          textAlignVertical: TextAlignVertical.center,
          baseStyle: TextStyle(fontSize: 12.0),
          dropdownSearchDecoration: InputDecoration(
            helperText: '',
            helperStyle: TextStyle(
              fontSize: 10,
            ),
            hintText: labelText,
            filled: true,
            fillColor: Colors.grey.shade200,
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
        ),
        onChanged: (String? item) => handleTextInput!(item!),
        selectedItem: null,
      ),
    );
  }
}
