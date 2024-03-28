import 'package:flutter/material.dart';

final ThemeData themeData = ThemeData(
  fontFamily: 'Inter',
  brightness: Brightness.light,
  useMaterial3: true,
  colorScheme: const ColorScheme(
    background: Colors.white,
    secondary: Colors.lightGreenAccent,
    brightness: Brightness.light,
    primary: Colors.lightBlueAccent,
    onPrimary: Colors.white,
    onSecondary: Colors.white,
    error: Colors.redAccent,
    onError: Colors.white,
    onBackground: Colors.black,
    surface: Colors.white,
    onSurface: Colors.black,
  ),
  appBarTheme: const AppBarTheme(
    elevation: 0,
    backgroundColor: Colors.lightBlueAccent,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      elevation: MaterialStateProperty.all(0),
      shadowColor: MaterialStateProperty.all(Colors.transparent),
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) => states.contains(MaterialState.disabled) ? Colors.grey : Colors.lightBlueAccent,
      ),
      foregroundColor: MaterialStateProperty.all(Colors.white),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(32.0),
        ),
      ),
      textStyle: MaterialStateProperty.all(
        const TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w600,
        ),
      ),
    ),
  ),
  scaffoldBackgroundColor: Colors.white,
);
