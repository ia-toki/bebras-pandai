import 'package:flutter/material.dart';

import 'base_colors.dart';

class FontTheme {
  // Black
  static TextStyle blackTitle() {
    return const TextStyle(
      color: Colors.black,
      fontSize: 30,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle blackTitleBold() {
    return const TextStyle(
      color: Colors.black,
      fontSize: 30,
      fontWeight: FontWeight.w800,
    );
  }

  static TextStyle blackSubtitleBold() {
    return const TextStyle(
      color: Colors.black,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle blackTextBold() {
    return const TextStyle(
      color: Colors.black,
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle blackBold36() {
    return const TextStyle(
      color: Colors.black,
      fontSize: 36,
      fontWeight: FontWeight.bold,
    );
  }

  // Grey
  static TextStyle greyTitle() {
    return const TextStyle(
      color: Colors.black,
      fontSize: 30,
      fontWeight: FontWeight.w500,
    );
  }

  static TextStyle greyBold36() {
    return const TextStyle(
      color: Colors.grey,
      fontSize: 36,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle greyNormal14() {
    return const TextStyle(
      color: Colors.grey,
      fontSize: 14,
      fontWeight: FontWeight.normal,
    );
  }

  // White
  static TextStyle whiteBold20() {
    return const TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle whiteBold36() {
    return const TextStyle(
      color: Colors.white,
      fontSize: 36,
      fontWeight: FontWeight.bold,
    );
  }

  // Blue
  static TextStyle blueBold20() {
    return const TextStyle(
      color: BaseColors.blue,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }

  // Red
  static TextStyle redBold20() {
    return const TextStyle(
      color: BaseColors.red,
      fontSize: 20,
      fontWeight: FontWeight.bold,
    );
  }

  static TextStyle redBold36() {
    return const TextStyle(
      color: BaseColors.red,
      fontSize: 36,
      fontWeight: FontWeight.bold,
    );
  }
}
