

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginproject/Web/Web_Cus/web_notice_screen.dart';
import 'package:loginproject/Web/Web_Member/web_join.dart';
import 'package:intl/intl.dart';

import '../../model/notice_model.dart';
import '../../model/qna_model.dart';
import '../Web_Member/web_login.dart';



class WebNotice extends StatefulWidget {
  WebNotice({super.key});

  @override
  State<StatefulWidget> createState() => _WebNoticeState();
}
class _WebNoticeState extends State<WebNotice> {
  bool showNotices = true;
  bool isLogin = false;


  void _showLoginAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('로그인 필요'),
          content: Text('글쓰기를 하시려면 로그인이 필요합니다. 로그인 페이지로 이동하시겠습니까?'),
          actions: [
            TextButton(
              child: Text('취소'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            Container(
              child: InkWell(
                onTap: () async {
                  isLogin = await Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => WebLogin(),
                  ));
                  setState(() {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WebNoticeScreen(),
                    ));
                  });
                },
                child: Text('확인'),
              ),
            ),
          ],
        );
      },
    );
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
            SizedBox(height: 70),
            Padding(
              padding: const EdgeInsets.fromLTRB(50, 0, 50, 0), // 양쪽에 여백 추가
              child: Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
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
                        "Q&A",
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

                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () {
                          _showLoginAlert(context);
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
                padding: const EdgeInsets.symmetric(horizontal: 16.0), // 공지사항과 Q&A 리스트에 좌우 여백 추가
                child: showNotices ? NoticeList() : QnaList(),
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
        baseUrl: "http://172.29.112.112:9090",
        contentType: "application/json",
      ),
    );

    try {
      Response res = await dio.get("/board1/list");
      if (res.statusCode == 200) {
        print(res.data);

        setState(() {
          list = (res.data as List).map((e) =>
              NoticeModel.fromJson(e as Map<String, dynamic>)).toList();
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
        final String date = DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(list[index].regdate ?? 0));
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
          baseUrl: "http://172.29.112.112:9090",
          contentType: "application/json",
        ),
      );

      try {
        Response res = await dio.get("/board/listAll");
        if (res.statusCode == 200) {
          print(res.data);

          setState(() {
            list = (res.data as List).map((e) => QnaModel.fromJson(e as Map<String, dynamic>)).toList();
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
        if(response.statusCode == 200) {
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
            final String date = DateFormat('yyyy-MM-dd').format(DateTime.fromMillisecondsSinceEpoch(list[index].regdate ?? 0));
            return ExpansionTile(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(list[index].title ?? "",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                  Text(
                    date
                  ),
                ],
              ),
              children: <Widget>[
                ListTile(
                  title: Text(list[index].content ?? "",),
                ),
                ListTile(
                  subtitle: Text('댓글입니다.'),
                ),
                ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        width: 1000,
                        child: TextField(),
                      ),
                      InkWell(
                        onTap: () {

                        },
                        child: Container(
                          child: Text('댓글쓰기'),
                        ),
                      ),
                    ],
                  )
                )
              ],
            );
          },
      );
    }
  }




