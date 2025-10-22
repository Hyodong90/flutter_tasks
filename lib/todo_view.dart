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
    return Scaffold();
  }
}


// 이거 모르겠어요 ㅠㅠ 아무데도안씀..  콜백도 모르겠고 함수 어떻게 사용하는지 아직 잘모르겠어요.,.,