import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../../../../../../core/constants/bebras_biro_dropdown.dart';

class BiroBebrasDropdownV2 extends StatelessWidget {
  const BiroBebrasDropdownV2(
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
      child: DropdownSearch<String>(
        selectedItem: initValue,
        validator: validator,
        popupProps: const PopupProps.menu(
          showSearchBox: true,
        ),
        items: bebrasBiroList,
        dropdownDecoratorProps: DropDownDecoratorProps(
          textAlignVertical: TextAlignVertical.center,
          baseStyle: const TextStyle(fontSize: 12),
          dropdownSearchDecoration: InputDecoration(
            helperText: '',
            helperStyle: const TextStyle(
              fontSize: 10,
            ),
            hintText: labelText,
            filled: true,
            fillColor: Colors.grey.shade200,
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(5),
            ),
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(5),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
        ),
        onChanged: (String? item) => handleTextInput!(item!),
      ),
    );
  }
}
