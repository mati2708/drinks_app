import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color.fromARGB(255, 15, 15, 15),
  onPrimary: Colors.white,
  primaryContainer: Color.fromARGB(255, 170, 0, 204),
  onPrimaryContainer: Color.fromARGB(255, 253, 253, 253),
  secondary: Color.fromARGB(255, 255, 65, 65),
  onSecondary: Color(0xFF000000),
  background: Colors.white,
  onBackground: Colors.black,
  surface: Color(0xFFFFFFFF),
  onSurface: Color(0xFF000000),
  error: Color(0xFFB00020),
  onError: Color(0xFFFFFFFF),
);

const darkColorScheme = ColorScheme(
  brightness: Brightness.dark,
  primary: Color.fromARGB(255, 230, 230, 230),
  onPrimary: Color(0xFF000000),
  primaryContainer: Color.fromARGB(255, 122, 0, 146),
  onPrimaryContainer: Color(0xFFE0E0E0),
  secondary: Color.fromARGB(255, 255, 65, 65),
  onSecondary: Color.fromARGB(255, 41, 41, 41),
  background: Color(0xFF121212),
  onBackground: Colors.white,
  surface: Color(0xFF1E1E1E),
  onSurface: Color(0xFFFFFFFF),
  error: Color(0xFFCF6679),
  onError: Color(0xFFFFFFFF),
);
