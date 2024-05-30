import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginproject/Web/Web_Cus/web_notice_screen.dart';
import 'package:loginproject/Web/Web_Cus/web_writing.dart';
import 'package:loginproject/Web/Web_Member/web_join.dart';

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
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                    SizedBox(width: 20),
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
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Padding(
                            padding: const EdgeInsets.fromLTRB(0, 0, 40, 10),
                            child: Container(
                              child: SearchBar(
                                trailing: [Icon(Icons.search)],
                                hintText: "검색어를 입력하세요",
                                constraints: BoxConstraints(
                                  maxWidth: 250,
                                  minHeight: 50,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )
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
    );
  }
}

class NoticeList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ExpansionTile(
          title: Text('공지사항 1'),
          children: <Widget>[
            ListTile(
              title: Text('공지사항 1의 상세 내용입니다.'),
            ),
          ],
        ),
        ExpansionTile(
          title: Text('공지사항 2'),
          children: <Widget>[
            ListTile(
              title: Text('공지사항 2의 상세 내용입니다.'),
            ),
          ],
        ),
        ExpansionTile(
          title: Text('공지사항 3'),
          children: <Widget>[
            ListTile(
              title: Text('공지사항 3의 상세 내용입니다.'),
            ),
          ],
        ),
      ],
    );
  }
}

class QnaList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ExpansionTile(
          title: Text('Q&A 1'),
          children: <Widget>[
            ListTile(
              title: Text('Q&A 1의 상세 내용입니다.'),
            ),
          ],
        ),
        ExpansionTile(
          title: Text('Q&A 2'),
          children: <Widget>[
            ListTile(
              title: Text('Q&A 2의 상세 내용입니다.'),
            ),
          ],
        ),
        ExpansionTile(
          title: Text('Q&A 3'),
          children: <Widget>[
            ListTile(
              title: Text('Q&A 3의 상세 내용입니다.'),
            ),
          ],
        ),
      ],
    );
  }
}

