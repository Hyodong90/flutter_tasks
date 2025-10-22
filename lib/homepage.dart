import 'package:flutter/material.dart';
import 'package:flutter_tasks/todo_detail_page.dart';
import 'package:flutter_tasks/todo_view.dart';

//클래스 생성해 함수 사용하도록 함
class ToDoEntity {
  ToDoEntity(this.title, this.description, this.isDone, this.isFavorite);

  final String title;
  final String? description;
  final bool isFavorite;
  final bool isDone;
}

// 타이틀, 상세설명, 즐겨찾기, 할일 등 변해야 하니 스테이트풀위젯으로,
class HomePage extends StatefulWidget {
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //텍스트 쓰게하는 컨드롤러
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();

  bool showDescription = false; // 설명 입력창 보일지 여부
  bool isFavorite = false; // 즐겨찾기 상태

  // 작성한거 리스트로 받아놓기
  List<ToDoEntity> todolist = [];

  //할일 쓰고 세이브 함수로 저장하기
  void saveToDo() {
    final title = titleController.text.trim();
    final desc = descController.text.trim();

    if (title.isEmpty) return;

    final todo = ToDoEntity(title, desc, false, isFavorite);

    //목록에 추가하기
    setState(() {
      todolist.add(todo);
    });

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
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          "효동's tasks",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child:
            //삼항연산자로 투두리스트 채워졌을때 다른화면 보이게
            todolist.isEmpty
            ? Container(
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
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.black54,
                      ),
                    ),
                    SizedBox(height: 12),
                    Text(
                      "할 일을 추가하고 Title 에서 \n 할 일을 추적하세요.",
                      style: TextStyle(
                        fontSize: 14,
                        height: 1.5,
                        color: Colors.black54,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            //리스트 뷰를 쓰면 안됨. 빌더까지써서 인덱스값을 구해오기
            : ListView.builder(
                itemCount: todolist.length,
                itemBuilder: (context, index) {
                  return todoItem(todolist[index]);
                },
              ),
      ),

      // 플로팅액션버튼으로 할일 추가하기
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            builder: (context) {
              return StatefulBuilder(
                builder: (context, setModalState) {
                  return Container(
                    color: Theme.of(context).cardTheme.color,
                    child: Padding(
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
                                setModalState(() {}), //입력 시 버튼 상태 변하게
                            //텍스트필드 콜백 함수. 엔터를 누르면 value에 작성한값이 들어가고 저장됨
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
                              // if를 써야 한번은 실행됨. 세부사항이 트루일때 삼항연산자쓰면 바로 넘어가서 안됨!!
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
                                  color: isFavorite
                                      ? Colors.amber
                                      : Colors.grey,
                                ),
                                onPressed: () {
                                  setModalState(() {
                                    isFavorite = !isFavorite;
                                  });
                                },
                              ),
                              Spacer(),
                              TextButton(
                                // 내용없이 저장눌렀을때 비활성화말고 스낵바 출력
                                onPressed: () {
                                  if (titleController.text.trim().isEmpty) {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        backgroundColor: Colors.red,
                                        content: Text(
                                          "할일을 입력하세요.",
                                          style: TextStyle(color: Colors.white),
                                        ),
                                        behavior: SnackBarBehavior
                                            .floating, // 플로팅 모드해서 마진을 줘야 띄울수 있음.
                                        margin: EdgeInsets.only(
                                          bottom: 20,
                                          left: 20,
                                          right: 20,
                                        ),
                                        duration: Duration(
                                          seconds: 2,
                                        ), // 2초 있다가 사라짐 듀레이션안하면 5초정도 기다려야하는듯
                                      ),
                                    );
                                    Navigator.pop(context);
                                  } else {
                                    saveToDo();
                                  }
                                },
                                //저장 글씨 - 내용이 있을때 색이 진해지게
                                child: Text(
                                  "저장",
                                  style: TextStyle(
                                    color: titleController.text.trim().isEmpty
                                        ? Theme.of(
                                            context,
                                          ).textTheme.bodyMedium?.color
                                        : Theme.of(
                                            context,
                                          ).textTheme.bodyLarge?.color,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          //  설명 입력창
                          if (showDescription)
                            Expanded(
                              child: TextField(
                                maxLines: null, //맥스라인을 널 하니 엔터로 다음 줄 가짐.
                                keyboardType:
                                    TextInputType.multiline, // 엔터치면 다음줄 가는거
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

  //todoItem 으로 따로 뺌. 할일 만들었을때 리스트로 작동하는 것들
  Widget todoItem(ToDoEntity todo) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => TodoDetailPage(todo: todo),
          ), // 할일 누르면 상세내역으로 가기
        );
      },
      child: Container(
        margin: EdgeInsets.symmetric(vertical: 8),
        padding: EdgeInsets.symmetric(horizontal: 16),
        height: 50,
        width: double.infinity,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 완료 버튼 눌러서 변경 가능하도록.
            IconButton(
              onPressed: () {
                setState(() {
                  //투두리스트에 인덱스 값 뽑아 올수있도록
                  int index = todolist.indexOf(todo);
                  todolist[index] = ToDoEntity(
                    todo.title,
                    todo.description,
                    !todo.isDone,
                    todo.isFavorite,
                  );
                });
              },
              icon: todo.isDone
                  ? Icon(Icons.check_circle_rounded)
                  : Icon(Icons.circle_outlined),
            ),
            SizedBox(width: 12),
            Text(
              todo.title,
              style: TextStyle(
                color: Theme.of(context).textTheme.bodyLarge?.color,
                //완료 버튼으로 타이틀에 줄이 그어지며 같이 움직이도록 삼항연산자
                decoration: todo.isDone
                    ? TextDecoration.lineThrough
                    : TextDecoration.none,
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {
                setState(() {
                  //투두리스트 인덱스값 뽑아와서 색 바뀌게 하기
                  int index = todolist.indexOf(todo);
                  todolist[index] = ToDoEntity(
                    todo.title,
                    todo.description,
                    todo.isDone,
                    !todo.isFavorite,
                  );
                });
              },
              icon: todo.isFavorite
                  ? Icon(Icons.star)
                  : Icon(Icons.star_border),
            ),
          ],
        ),
      ),
    );
  }
}
