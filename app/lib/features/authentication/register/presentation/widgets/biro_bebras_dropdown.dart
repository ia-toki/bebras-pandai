import 'package:bebras_pandai/core/constants/bebrasBiroDropdown.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class BiroBebrasDropdown extends StatelessWidget {
  BiroBebrasDropdown(this.labelText, this.handleTextInput, this.validator);

  final String labelText;
  final void Function (String value)? handleTextInput;
  final String? Function(BebrasBiro?)? validator;

  List<BebrasBiro> get dropdownItems {
    var list = bebrasBiroList.where((el) => el.isActive).toList();
    var menuItems = list
        .map((element) => BebrasBiro(
      bebrasBiroUniv: element.bebrasBiroUniv,
      valueDropdown: element.valueDropdown,
      isActive: element.isActive,),
    ).toList();
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 63.0,
      child: DropdownSearch<BebrasBiro>(
        validator: validator,
        itemAsString: (BebrasBiro bebras) => bebras.userAsString(),
        popupProps: PopupProps.menu(
          showSearchBox: true,
        ),
        items: dropdownItems,
        dropdownDecoratorProps: DropDownDecoratorProps(
          textAlignVertical: TextAlignVertical.center,
          baseStyle: TextStyle(fontSize: 12.0),
          dropdownSearchDecoration: InputDecoration(
            helperText: '',
            helperStyle: TextStyle(fontSize: 10,),
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
        onChanged: (BebrasBiro? test) => handleTextInput!(test!.valueDropdown),
          // print(test?.valueDropdown);
        selectedItem: null,
      ),
    );
  }

}