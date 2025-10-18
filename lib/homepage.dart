import 'package:flutter/material.dart';

class ToDoEntity {
  ToDoEntity(this.title, this.description, this.isDone, this.isFavorite);

  final String title;
  final String? description;
  final bool isFavorite;
  final bool isDone;
}

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "효동's tasks",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        children: [Text("아직 할 일이 없음"), Text("할 일을 추가하고 $Title 에서 할 일을 추적하세요.")],
      ),
    );
  }
}
