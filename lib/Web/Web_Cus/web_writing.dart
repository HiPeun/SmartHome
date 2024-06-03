import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import '../Web_Member/web_login.dart';
import '../Web_Member/web_join.dart';
import '../Web_Cus/web_notice.dart';

class WebWriting extends StatefulWidget {
  WebWriting({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _WebWritingState();
}

class _WebWritingState extends State<WebWriting> {
  TextEditingController titleController = TextEditingController();
  TextEditingController writerController = TextEditingController();
  TextEditingController contentController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    writerController.dispose();
    contentController.dispose();
    super.dispose();
  }

  void submitPost(String title, String content, String writer, String attachment) async {
    try {
      final Map<String, dynamic> data = {
        'id': 'ljy3852',
        'title': title,
        'content': content,
        'attachment': attachment,
      };
      final Dio dio = Dio(BaseOptions(baseUrl: "http://192.168.0.177:9090/"));
      Response response = await dio.post("/board/insert/", data: data);
      if (response.statusCode == 200) {
        print('글이 등록되었습니다.');
      } else {
        print('글 등록에 실패했습니다: ${response.statusMessage}');
      }
    } catch (e) {
      if (e is DioError) {
        print('글 등록에 실패했습니다: 네트워크 오류입니다.');
        print('DioError: ${e.message}');
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
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => WebLogin(),
                          ));
                        },
                        child: Text(
                          "로그인",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => WebJoin(),
                          ));
                        },
                        child: Text(
                          "회원가입",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => WebNotice(),
                          ));
                        },
                        child: Text(
                          "고객센터",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
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
            SizedBox(height: 50),
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
                          controller: writerController,
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
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            submitPost(
                              titleController.text,
                              contentController.text,
                              writerController.text,
                              "dd",
                            );
                          },
                          child: Text("글등록"),
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
                      ),
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




