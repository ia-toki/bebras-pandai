import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../../../../core/constants/indonesia_province.dart';

class ProvinceDropdown extends StatelessWidget {
  const ProvinceDropdown(
    this.labelText,
    this.handleTextInput,
    this.validator, {
    super.key,
  });

  final String labelText;
  final void Function(String value)? handleTextInput;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      // margin: const EdgeInsets.only(top: 10),
      height: 63,
      child: DropdownSearch<String>(
        validator: validator,
        popupProps: const PopupProps.menu(
          showSearchBox: true,
        ),
        items: provinceList,
        dropdownDecoratorProps: DropDownDecoratorProps(
          textAlignVertical: TextAlignVertical.center,
          baseStyle: const TextStyle(fontSize: 12),
          dropdownSearchDecoration: InputDecoration(
            helperText: '',
            helperStyle: const TextStyle(fontSize: 10),
            hintText: labelText,
            filled: true,
            fillColor: Colors.grey.shade200,
            border: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(10),
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
        ),
        onChanged: (String? item) => handleTextInput!(item!),
      ),
    );
  }
}
