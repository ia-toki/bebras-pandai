import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/constants/indonesia_province.dart';

class ProvinceDropdown extends StatelessWidget {
  const ProvinceDropdown(
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
      height: 63,
      child: DropdownSearch<String>(
        selectedItem: initValue,
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
            filled: true,
            fillColor: Colors.grey.shade200,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade200),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade400),
            ),
          ),
        ),
        onChanged: (String? item) => handleTextInput!(item!),
      ),
    );
  }
}
