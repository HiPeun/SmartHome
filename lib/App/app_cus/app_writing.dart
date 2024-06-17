import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../model/qna_model.dart';
import '../main.dart';

class AppWriting extends StatefulWidget {
  final QnaModel? qna;

  AppWriting({Key? key, this.qna}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _AppWritingState();
}

class _AppWritingState extends State<AppWriting> {
  TextEditingController titleController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  TextEditingController attachmentController = TextEditingController();

  @override
  void initState() {
    super.initState();
    //String 값에 Null을 허용해주지 않아서 발생하는 오류이다.
    nameController.text = user["name"];
    if (widget.qna != null) {
      titleController.text = widget.qna!.title ?? '';
      contentController.text = widget.qna!.content ?? '';
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    nameController.dispose();
    attachmentController.dispose();
    super.dispose();
  }

  void updatePost() async {
    try {
      final Map<String, dynamic> data = {
        'pno': widget.qna?.pno, // 다시한번
        'name': nameController.text,
        'title': titleController.text,
        'content': contentController.text,
        'attachment': attachmentController.text,
      };
      final Dio dio = Dio(BaseOptions(
        baseUrl: "http://192.168.0.177:9090",
        headers: {
          'Content-Type': 'application/json',
        },
      ));
      Response res = await dio.post("/board/update", data: data);
      if (res.statusCode == 200 && res.data == true) {
        print('글이 수정되었습니다.');
        Navigator.pop(context); // 현재 페이지를 닫습니다.
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('자주묻는질문'),
              content: Text('글이 수정되었습니다.'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 대화 상자를 닫습니다.
                  },
                  child: Text('OK'),
                ),
              ],
            );
          },
        );
      } else {
        print('글 수정에 실패했습니다: ${res.statusMessage}');
      }
    } catch (e) {
      if (e is DioError) {
        print('글 수정에 실패했습니다: 네트워크 오류입니다.');
        print('DioError: $e');
      } else {
        print('글 수정에 실패했습니다: $e');
      }
    }
  }

  void submitPost() async {
    try {
      final Map<String, dynamic> data = {
        'mbno': user['mbno'],
        'name': nameController.text,
        'title': titleController.text,
        'content': contentController.text,
        'attachment': attachmentController.text,
      };
      final Dio dio = Dio(BaseOptions(
        baseUrl: "http://192.168.0.177:9090",
        headers: {
          'Content-Type': 'application/json',
        },
      ));
      Response res = await dio.post("/board/insert", data: data);
      if (res.statusCode == 200 && res.data == true) {
        print('글이 등록되었습니다.');
        Navigator.pop(context); // 현재 페이지를 닫습니다.

        // 잠시 지연 후 showDialog 호출
        Future.delayed(Duration(milliseconds: 100), () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('글쓰기 완료'),
                content: Text('글이 등록되었습니다.'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // 대화 상자를 닫습니다.
                    },
                    child: Text('OK'),
                  ),
                ],
              );
            },
          );
        });
      } else {
        print('글 등록에 실패했습니다: ${res.statusMessage}');
      }
    } catch (e) {
      if (e is DioError) {
        print('글 등록에 실패했습니다: 네트워크 오류입니다.');
        print('DioError: $e');
      } else {
        print('글 등록에 실패했습니다: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
          children: [
            Container(
              height: 170,
              width: double.infinity,
              decoration: BoxDecoration(
                color: Color(0xFFD3CDC8),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 50, bottom: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Conven",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                            ),
                          ),
                          Text(
                            "무엇을 도와드릴까요?",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              child: Text(
                "고객센터",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Container(
                width: double.infinity,
                height: 1.5,
                decoration: BoxDecoration(color: Colors.black54),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: 900,
                        child: TextField(
                          controller: titleController,
                          decoration: InputDecoration(
                            labelText: "제목",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      SizedBox(
                        width: 900,
                        child: TextField(
                          readOnly: true,
                          controller: nameController,
                          decoration: InputDecoration(
                            labelText: "작성자",
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        controller: contentController,
                        maxLines: 10,
                        decoration: InputDecoration(
                          labelText: "내용",
                          border: OutlineInputBorder(),
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ElevatedButton(
                              onPressed: () {},
                              child: Text("첨부파일"),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(150, 50),
                                backgroundColor: Color(0xFFD3CDC8),
                                textStyle: TextStyle(fontSize: 18),
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                              height: 50,
                            ),
                            ElevatedButton(
                              onPressed: () {
                                widget.qna != null
                                    ? updatePost()
                                    : submitPost();
                              },
                              child: Text(widget.qna != null ? "글수정" : "글등록"),
                              style: ElevatedButton.styleFrom(
                                minimumSize: Size(150, 50),
                                backgroundColor: Color(0xFFD3CDC8),
                                textStyle: TextStyle(fontSize: 18),
                                foregroundColor: Colors.black,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.zero,
                                ),
                              ),
                            ),
                          ]),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
