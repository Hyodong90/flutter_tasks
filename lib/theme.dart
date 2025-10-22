import 'package:flutter/material.dart';


//라이트테마 지정
final lightTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.black,
    brightness: Brightness.light,
  ),
  scaffoldBackgroundColor: Colors.grey[400],
  cardColor: Colors.white,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.black),
    bodyMedium: TextStyle(color: Colors.grey),
  ),
);

//다크테마 지정
final darkTheme = ThemeData(
  colorScheme: ColorScheme.fromSeed(
    seedColor: Colors.white,
    brightness: Brightness.dark,
  ),
  scaffoldBackgroundColor: Colors.black26,
  cardColor: const Color.fromARGB(136, 64, 61, 61),
  dividerColor: Colors.black38,
  textTheme: TextTheme(
    bodyLarge: TextStyle(color: Colors.white),
    bodyMedium: TextStyle(color: Colors.grey),
  ),
);
