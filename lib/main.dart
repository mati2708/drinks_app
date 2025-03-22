import 'package:drinks_app/layout/colors.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'screens/drinks_list_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // Flaga do zarządzania trybem, domyślnie jasny
  bool isDarkMode = false;

  void _toggleTheme() {
    setState(() {
      isDarkMode = !isDarkMode; // Przełącz tryb
    });
  }


  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Koktajle App',
      theme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
        colorScheme: lightColorScheme
      ),
      darkTheme: ThemeData(
        textTheme: GoogleFonts.montserratTextTheme(Theme.of(context).textTheme),
        colorScheme: darkColorScheme
      ),
      themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
      home: DrinksListScreen(toggleTheme: _toggleTheme),
    );
  }
}