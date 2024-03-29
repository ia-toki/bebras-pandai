import 'package:flutter/material.dart';

class BaseColors {
  static const int _primaryValue = 0xFF4FCCA4;

  static const MaterialColor primarySwatch = MaterialColor(
    _primaryValue,
    <int, Color>{
      50: Color(0xFFEAF9F4),
      100: Color(0xFFCAF0E4),
      200: Color(0xFFA7E6D2),
      300: Color(0xFF84DBBF),
      400: Color(0xFF69D4B2),
      500: Color(_primaryValue),
      600: Color(0xFF48C79C),
      700: Color(0xFF3FC092),
      800: Color(0xFF36B989),
      900: Color(0xFF26AD78),
    },
  );

  static const Color black = Color.fromARGB(255, 18, 18, 20);
  static const Color white = Colors.white;
  static const Color red = Color(0xFFea526f);
  static const Color blue = Color(0xFF01b4fb);
  static const Color yellow = Color(0xFFfeb451);
  static const Color asparagus = Color(0xFF6da34d);
  static const Color grey = Colors.grey;
  static const Color brightBlue = Color(0xFF1BB8E1);
  static const Color greyCustom = Color(0xFFD9D9D9);
}
