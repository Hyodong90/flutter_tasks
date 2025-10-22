import 'package:flutter/material.dart';
import 'package:flutter_tasks/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      themeMode: ThemeMode.light,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.grey,
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: Colors.grey[400],
      ),
      darkTheme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.black26,
          brightness: Brightness.dark,
        ),
        scaffoldBackgroundColor: Colors.black,
        dividerColor: Colors.black38,
      ),
      home: HomePage(),
    );
  }
}
