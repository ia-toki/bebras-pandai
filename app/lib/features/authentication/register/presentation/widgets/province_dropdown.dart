import 'package:bebras_pandai/core/constants/indonesiaProvince.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';

class ProvinceDropdown extends StatelessWidget {
  ProvinceDropdown(this.labelText, this.handleTextInput, this.validator);

  final String labelText;
  final void Function (String value)? handleTextInput;
  final String? Function(IndonesiaProvince?)? validator;

  List<IndonesiaProvince> get dropdownIndonesiaProvince {
    var list = provinceList.where((el) => el.isActive).toList();
    var menuItems = list
        .map((element) => IndonesiaProvince(
      provinceName: element.provinceName,
      valueProvince: element.valueProvince,
      isActive: element.isActive,),
    ).toList();
    return menuItems;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.only(top: 10),
      height: 63.0,
      child: DropdownSearch<IndonesiaProvince>(
        validator: validator,
        itemAsString: (IndonesiaProvince indonesiaProvince) =>
            indonesiaProvince.userAsString(),
        popupProps: PopupProps.menu(
          showSearchBox: true,
        ),
        items: dropdownIndonesiaProvince,
        dropdownDecoratorProps: DropDownDecoratorProps(
          textAlignVertical: TextAlignVertical.center,
          baseStyle: TextStyle(fontSize: 12.0),
          dropdownSearchDecoration: InputDecoration(
            helperText: '',
            helperStyle: TextStyle(fontSize: 10),
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
        // onChanged: (IndonesiaProvince? test) => print(test?.valueProvince),
        onChanged: (IndonesiaProvince? test) => handleTextInput!(test!.valueProvince),
        selectedItem: null,
      ),
    );
  }
}