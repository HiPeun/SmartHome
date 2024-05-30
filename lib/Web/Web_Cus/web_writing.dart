
import 'dart:core';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginproject/Web/Web_Cus/web_notice.dart';
import 'package:loginproject/Web/Web_Member/web_join.dart';
import '../Web_Member/web_login.dart';

class WebWriting extends StatefulWidget {
  WebWriting({super.key});

  @override
  State<StatefulWidget> createState() => _WebWritingState();
}
class FilePickerExample extends StatefulWidget {
  @override
  _FilePickerExampleState createState() => _FilePickerExampleState();
}

class _FilePickerExampleState extends State<FilePickerExample> {
  String? _filePath;

  void _pickFile() async {
    String? filePath = await FilePicker.platform.pickFiles().then((result) {
      if (result != null && result.count > 0) {
        return result.files.single.path;
      } else {
        return null;
      }
    });


    if (filePath != null) {
      setState(() {
        _filePath = filePath;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('File Picker Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _pickFile,
              child: Text('Select File'),
            ),
            SizedBox(height: 20),
            Text(
              _filePath ?? 'No file selected',
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: FilePickerExample(),
  ));
}

class _WebWritingState extends State<WebWriting> {
  TextEditingController titleController = TextEditingController();
  TextEditingController writerController = TextEditingController();
  TextEditingController contentController = TextEditingController();
  String? attachment;


  void submitPost(String title, String content, String writer, String attachment) async {
    try {
      final Map<String, dynamic> data = {
        'title': title,
        'content': content,
        'name': writer,
        'attachment': attachment,
      };

      final Dio dio = Dio(BaseOptions(baseUrl: "http://192.168.0.182:9090"));
      Response res = await dio.post("/board/insert", data: data);

      if (res.statusCode == 200) {
        print('글이 등록되었습니다.');
      } else {
        print('글 등록에 실패했습니다: ${res.statusMessage}');
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
                            )),
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
                      Row(
                        children: [
                          ElevatedButton(
                            onPressed: () async {
                              String? filePath = await FilePicker.platform.pickFiles().then((result) {
                                if (result != null) {
                                  return result.files.single.path;
                                }
                              });

                              setState(() {
                                attachment = filePath; // 파일 경로가 없으면 null이 될 수 있음
                              });
                            },
                            child: Text("파일 선택"),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xFFD3CDC8),
                              foregroundColor: Colors.black,
                              textStyle: TextStyle(fontSize: 16),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.zero,
                              ),
                            ),
                          ),
                          SizedBox(width: 16),
                          Text(attachment ?? "선택된 파일 없음"), // attachment 값이 null일 경우 "선택된 파일 없음" 출력
                        ],
                      ),



                      SizedBox(height: 16),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            submitPost(
                            titleController.text,
                            contentController.text,
                            writerController.text,
                              attachment!,
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
