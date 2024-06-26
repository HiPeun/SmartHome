import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:loginproject/App/app_screen/app_login.dart'; // 로그인 페이지를 import
import 'package:loginproject/main.dart';

import '../../model/notice_model.dart';
import '../../model/qna_model.dart';
import '../App_Cus/App_writing.dart';

class AppNotice extends StatefulWidget {
  AppNotice({super.key});

  @override
  State<StatefulWidget> createState() => _AppNoticeState();
}

class _AppNoticeState extends State<AppNotice> {
  bool showNotices = true;

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
                padding: const EdgeInsets.only(top: 30, left: 30, bottom: 20),
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
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showNotices = true;
                      });
                    },
                    child: Row(
                      children: [
                        Text(
                          "공지사항",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(70, 50),
                      backgroundColor: showNotices ? Color(0x66Bde0) : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 80,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        showNotices = false;
                      });
                    },
                    child: Text(
                      "자주묻는질문",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(70, 50),
                      backgroundColor: !showNotices ? Color(0x66Bde0) : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
              child: Container(
                width: double.infinity,
                height: 1.5,
                decoration: BoxDecoration(color: Colors.black54),
              ),
            ),
            SizedBox(height: 30),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                // 공지사항과 Q&A 리스트에 좌우 여백 추가
                child: showNotices ? NoticeList() : QnaList(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () {
                  if (user.isNotEmpty) {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AppWriting(),
                    ));
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text('로그인 필요'),
                          content:
                              Text('글쓰기를 하려면 로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: Text('취소'),
                            ),
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => AppLogin(),
                                ));
                              },
                              child: Text('확인'),
                            ),
                          ],
                        );
                      },
                    );
                  }
                },
                child: Text("글쓰기"),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(160, 45),
                  backgroundColor: Color(0xFFD3CDC8),
                  textStyle: TextStyle(fontSize: 20),
                  foregroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
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

class NoticeList extends StatefulWidget {
  @override
  _NoticeListState createState() => _NoticeListState();
}

class _NoticeListState extends State<NoticeList> {
  List<NoticeModel> list = [];

  @override
  void initState() {
    super.initState();
    getNoticeList();
  }

  void getNoticeList() async {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: "http://192.168.0.177:9090",
        contentType: "application/json",
      ),
    );

    try {
      Response res = await dio.get("/board1/list");
      if (res.statusCode == 200) {
        print(res.data);

        setState(() {
          list = (res.data as List)
              .map((e) => NoticeModel.fromJson(e as Map<String, dynamic>))
              .toList();
        });
        print(list);
      }
    } catch (e) {
      print("Failed to load data: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final String date = DateFormat('yyyy-MM-dd').format(
            DateTime.fromMillisecondsSinceEpoch(list[index].regdate ?? 0));
        return ExpansionTile(
          title: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                list[index].title ?? "",
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 10,
              ),
              Row(
                children: [
                  Text(
                    date,
                  ),
                ],
              ),
            ],
          ),
          children: <Widget>[
            ListTile(
              title: Text(list[index].content ?? ""),
            ),
          ],
        );
      },
    );
  }
}

class QnaList extends StatefulWidget {
  @override
  _QnaListState createState() => _QnaListState();
}

class _QnaListState extends State<QnaList> {
  List<QnaModel> list = [];

  @override
  void initState() {
    super.initState();
    getQnaList();
  }

  void getQnaList() async {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: "http://192.168.0.177:9090",
        contentType: "application/json",
      ),
    );

    try {
      Response res = await dio.get("/board/listAll");
      if (res.statusCode == 200) {
        print(res.data);

        setState(() {
          list = (res.data as List)
              .map((e) => QnaModel.fromJson(e as Map<String, dynamic>))
              .toList();
        });
        print(list);
      }
    } catch (e) {
      print("Failed to load data: $e");
    }
  }

  void deleteQna(int? pno) async {
    Dio dio = Dio(
      BaseOptions(
        baseUrl: "http://192.168.0.177:9090",
        contentType: "application/json",
      ),
    );

    try {
      Response res = await dio.post("/board/delete", data: {'pno': pno});
      if (res.statusCode == 200 && res.data == true) {
        setState(() {
          list.removeWhere((qna) => qna.pno == pno);
        });
        print("삭제되었습니다.");
      } else {
        print("삭제에 실패했습니다.");
      }
    } catch (e) {
      print("Failed to delete data: $e");
    }
  }

  void qnainsert(int pno, int mbno, String content, int regdate) async {
    final dio = Dio();
    try {
      final response = await dio.get(
        "http://192.168.0.177:9090/comm/insert",
        data: {
          'pno': pno,
          'mbno': mbno,
          'content': content,
          'regdate': regdate,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("댓글 작성이 완료되었습니다."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('확인'),
                ),
              ],
            );
          },
        );
      } else {
        print("글 등록 실패: ${response.data}");
      }
    } catch (e) {
      print("글 등록 실패: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final String date = DateFormat('yyyy-MM-dd').format(
            DateTime.fromMillisecondsSinceEpoch(list[index].regdate ?? 0));

        return ExpansionTile(
          title: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                children: [
                  Text(
                    list[index].title ?? "",
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
              Row(
                children: [
                  Text(date),
                ],
              ),
            ],
          ),
          children: <Widget>[
            ListTile(
              title: Text(list[index].content ?? ""),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (list[index].mbno == user['mbno'])
                    IconButton(
                      icon: Icon(Icons.edit),
                      onPressed: () {
                        Navigator.of(context)
                            .push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    AppWriting(qna: list[index]),
                              ),
                            )
                            .then((value) => getQnaList());
                      },
                    ),
                  if (list[index].mbno == user['mbno'])
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text("삭제 확인"),
                              content: Text("정말 삭제하시겠습니까?"),
                              actions: <Widget>[
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("취소"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    deleteQna(list[index].pno);
                                    Navigator.of(context).pop();
                                  },
                                  child: Text("확인"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
