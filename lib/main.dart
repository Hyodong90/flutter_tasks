import 'package:flutter/material.dart';
import 'package:flutter_tasks/homepage.dart';
import 'package:flutter_tasks/theme.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.dark,
      theme: lightTheme,
      darkTheme: darkTheme,

      home: HomePage(),
    );
  }
}
