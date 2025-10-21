import 'package:flutter/material.dart';
import 'package:flutter_tasks/todo_view.dart';

//일단 만듬
class ToDoEntity {
  ToDoEntity(this.title, this.description, this.isDone, this.isFavorite);

  final String title;
  final String? description;
  final bool isFavorite;
  final bool isDone;
}

class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  bool showDescription = false; // 설명 입력창 보일지 여부
  bool isFavorite = false; // 즐겨찾기 상태

  // 작성한거 리스트로 받아놓기
  List<ToDoEntity> todolist = [];

  //할일 쓰고 세이브 함수
  void saveToDo() {
    final title = titleController.text.trim();
    final desc = descController.text.trim();

    if (title.isEmpty) return;

    final todo = ToDoEntity(title, desc, false, isFavorite);

    //목록에 추가하기
    setState(() {
      todolist.add(todo);
    });
    print(
      " 저장됨: ${todo.title}, 설명: ${todo.description}, 즐겨찾기: ${todo.isFavorite}",
    );

    // 입력 초기화
    titleController.clear();
    descController.clear();
    isFavorite = false;
    showDescription = false;

    Navigator.pop(context); // 창 닫기
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.grey[400],
      appBar: AppBar(
        title: Text(
          "효동's tasks",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Container(
          height: 230,
          width: double.infinity,

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            children: [
              SizedBox(height: 12),
              Image.asset('assets/1.webp', width: 100, height: 100),
              SizedBox(height: 12),
              Text(
                "아직 할 일이 없음",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 12),
              Text(
                "할 일을 추가하고 Title 에서 \n 할 일을 추적하세요.",
                style: TextStyle(fontSize: 14, height: 1.5),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setModalState) {
                  return Padding(
                    padding: EdgeInsets.only(
                      top: 12,
                      left: 20,
                      right: 20,
                      bottom: MediaQuery.of(context).viewInsets.bottom,
                    ),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        //  제목 입력 필드
                        TextField(
                          controller: titleController,
                          maxLines: 1,
                          style: TextStyle(fontSize: 14),
                          onChanged: (value) =>
                              setModalState(() {}), //입력 시 버튼 상태 갱신
                          onSubmitted: (value) {
                            if (value.trim().isNotEmpty) saveToDo();
                          },
                          autofocus: true,
                          textInputAction: TextInputAction.done, //엔터 누를시 저장
                          decoration: InputDecoration(
                            hintText: "새 할 일",
                            border: InputBorder.none,
                          ),
                        ),

                        Row(
                          children: [
                            if (!showDescription)
                              IconButton(
                                icon: Icon(
                                  Icons.short_text_rounded,
                                  color: showDescription
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  setModalState(() {
                                    showDescription = !showDescription;
                                  });
                                },
                              ),
                            IconButton(
                              icon: Icon(
                                isFavorite ? Icons.star : Icons.star_border,
                                color: isFavorite ? Colors.amber : Colors.grey,
                              ),
                              onPressed: () {
                                setModalState(() {
                                  isFavorite = !isFavorite;
                                });
                              },
                            ),
                            Spacer(),
                            TextButton(
                              onPressed: titleController.text.trim().isEmpty
                                  ? null
                                  : () {
                                      saveToDo();
                                    },
                              child: Text(
                                "저장",
                                style: TextStyle(
                                  color: titleController.text.trim().isEmpty
                                      ? Colors.grey
                                      : Colors.black,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        //  설명 입력창
                        if (showDescription)
                          // 세부정보추가 줄바꿈하려 익스펜디드로 감쌌는데 전체화면됨. 컨터이너로 감싸줘야하나/ 엔터눌러도 다음으로 그냥 키보드창이내려감,
                          SizedBox(
                            height: 200,
                            child: TextField(
                              textInputAction: TextInputAction
                                  .newline, // 엔터치면 다음줄로 가야하는데 왜ㅏㄴ가지
                              controller: descController,
                              style: TextStyle(fontSize: 14),
                              decoration: InputDecoration(
                                hintText: "세부정보 추가",
                                hintStyle: TextStyle(
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                                border: InputBorder.none,
                              ),
                            ),
                          ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
        backgroundColor: Colors.red,
        shape: CircleBorder(),
        child: Icon(Icons.add, color: Colors.white, size: 24),
      ),
    );
  }
}
