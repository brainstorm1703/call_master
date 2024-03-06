import 'package:flutter/material.dart';

final theme = ThemeData(
  scaffoldBackgroundColor: const Color.fromARGB(251, 30, 30, 30),
  appBarTheme: const AppBarTheme(
    iconTheme: IconThemeData(color: Colors.white),
    elevation: 0,
    backgroundColor: Color.fromARGB(30, 30, 30, 30),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 20,
      fontWeight: FontWeight.w700,
    ),
  ),
  textTheme: const TextTheme(
    titleLarge: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w700,
      fontSize: 19,
    ),
    titleMedium: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w500,
      fontSize: 13,
    ),
    titleSmall: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 12,
    ),
    displaySmall: TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w400,
      fontSize: 11,
    ),
  ),
  inputDecorationTheme: const InputDecorationTheme(
    enabledBorder: enabledBorder,
  ),
);
const enabledBorder = OutlineInputBorder(
  borderRadius: BorderRadius.all(Radius.circular(20.0)),
  borderSide: BorderSide(color: Color.fromARGB(251, 12, 186, 112)),
);
