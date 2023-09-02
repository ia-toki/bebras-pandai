import 'package:flutter/material.dart';

import 'base_colors.dart';

class FontTheme {
  // Black
  static TextStyle blackBold20() {
    return const TextStyle(
        color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold);
  }

  // White
  static TextStyle whiteBold20() {
    return const TextStyle(
        color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold);
  }

  static TextStyle whiteBold36() {
    return const TextStyle(
        color: Colors.white, fontSize: 36, fontWeight: FontWeight.bold);
  }

  // Blue
  static TextStyle blueBold20() {
    return const TextStyle(
        color: BaseColors.blue, fontSize: 20, fontWeight: FontWeight.bold);
  }

  // Red
  static TextStyle redBold20() {
    return const TextStyle(
        color: BaseColors.red, fontSize: 20, fontWeight: FontWeight.bold);
  }

  static TextStyle redBold36() {
    return const TextStyle(
        color: BaseColors.red, fontSize: 36, fontWeight: FontWeight.bold);
  }
}
