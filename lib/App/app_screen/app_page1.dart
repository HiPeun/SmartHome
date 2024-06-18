import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../../model/notice_model.dart';
import '../../model/qna_model.dart';
import '../App_Cus/App_writing.dart';
import '../app_screen/app_login.dart';
import '../../main.dart';

class AppNotice extends StatefulWidget {
  AppNotice({super.key});

  @override
  State<StatefulWidget> createState() => _AppNoticeState();
}

class _AppNoticeState extends State<AppNotice> {
  bool showNotices = true;
  bool isLogin = false;

  @override
  void initState() {
    super.initState();
    // 로그인 상태 체크
    if (user.isEmpty) {
      // 로그인 페이지로 리디렉션
      WidgetsBinding.instance.addPostFrameCallback((_) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => AppLogin()),
        );
      });
    } else {
      setState(() {
        isLogin = true;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (!isLogin) {
      return Scaffold(
        body: Center(child: CircularProgressIndicator()),
      ); // 로그인 상태가 확인될 때까지 로딩 화면 표시
    }

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
                    child: Text(
                      "공지사항",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(70, 50),
                      backgroundColor: showNotices ? Colors.grey : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
                      ),
                    ),
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
                      backgroundColor: !showNotices ? Colors.grey : null,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.zero,
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
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => AppWriting(),
                  ));
                },
                child: Text("글쓰기"),
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(160, 45),
                  backgroundColor: Color(0xFFD3CDC8),
                  textStyle: TextStyle(fontSize: 20),
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
        baseUrl: "http://192.168.0.188:9090",
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
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                list[index].title ?? "",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Container(
                height: 10,
              ),
              Text(
                date,
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
        baseUrl: "http://192.168.0.188:9090",
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

  void qnainsert(int pno, int mbno, String content, int regdate) async {
    final dio = Dio();
    try {
      final response = await dio.get(
        "http://192.168.0.188:9090/comm/insert",
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

  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: list.length,
      itemBuilder: (context, index) {
        final String date = DateFormat('yyyy-MM-dd').format(
            DateTime.fromMillisecondsSinceEpoch(list[index].regdate ?? 0));
        return ExpansionTile(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                list[index].title ?? "",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Container(
                height: 10,
              ),
              Text(date),
            ],
          ),
          children: <Widget>[
            ListTile(
              title: Text(
                list[index].content ?? "",
              ),
            ),
          ],
        );
      },
    );
  }
}
