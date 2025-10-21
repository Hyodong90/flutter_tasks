import 'package:flutter/material.dart';
import 'homepage.dart'; // ToDoEntity 불러오기

class ToDoView extends StatelessWidget {
  const ToDoView({
    super.key,
    required this.toDo,
    required this.onToggleFavorite,
    required this.onToggleDone,
  });

  final ToDoEntity toDo;
  final VoidCallback onToggleFavorite;
  final VoidCallback onToggleDone;

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ListView(children: [Container()]));
  }
}
