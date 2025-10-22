import 'package:flutter/material.dart';
import 'package:flutter_tasks/homepage.dart';
import 'package:flutter_tasks/main.dart';

class TodoDetailPage extends StatefulWidget {
  final ToDoEntity todo;
  const TodoDetailPage({super.key, required this.todo});

  @override
  State<TodoDetailPage> createState() => _TodoDetailPageState();
}

class _TodoDetailPageState extends State<TodoDetailPage> {
  final TextEditingController destitleController = TextEditingController();
  final TextEditingController desdescController = TextEditingController();

  @override
  void initState() {
    super.initState();

    destitleController.text = widget.todo.title;
    desdescController.text = widget.todo.description ?? '세부 내용은 다음과 같습니다.';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        leading: BackButton(),
        actions: [
          IconButton(
            icon: Icon(
              widget.todo.isFavorite ? Icons.star : Icons.star_border,
              color: widget.todo.isFavorite ? Colors.amber : Colors.grey,
            ),
            onPressed: () {},
          ),
        ],
      ),

      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: destitleController,
              decoration: InputDecoration(border: InputBorder.none),

              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Icon(Icons.short_text_rounded),
                SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    controller: desdescController,
                    style: TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "세부 내용은 다음과 같습니다.",
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(left: 35),
              child: TextField(
                maxLines: null, //맥스라인을 널 하니 엔터로 다음 줄 가짐.
                keyboardType: TextInputType.multiline,
                style: TextStyle(fontSize: 14),
                decoration: InputDecoration(
                  hintText: "세부 내용은 여기에 작성합니다.",
                  border: InputBorder.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
