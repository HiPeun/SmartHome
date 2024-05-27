

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';


class Page1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text(
              "Conven",
              style: TextStyle(
                fontSize: 32.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomService(),
            Container(
              width: 400,
              height: 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SearchBar(
                    trailing: [
                      IconButton(
                        icon: const Icon(Icons.search),
                        onPressed: () {},
                      ),
                    ],
                    constraints: BoxConstraints(maxHeight: 100, maxWidth: 250),
                    shape: MaterialStateProperty.all(
                      ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    hintText: "검색어를 입력하세요",
                  )
                ],
              ),
            ),
            Container(
              width: double.infinity,
              height: 10,
              color: Color(0xFFE5E5E1),
            ),
            ServiceTile(
              text: "스마트홈 서비스 이용약관 변경 공지  ",
              text1: "2024-05-25",
              text2:
                  "안녕하세요. 저는 대표님입니다 대표로서 한마디 하자면 이 어플 너무 잘만든거 같아서 칭찬좀 할려고 합니다. 알겠죠 그러니깐 알아서들하세요 ㅎㅎ ",
            ),
            ServiceTile(
              text: "스마트홈 이용안내",
              text1: "2024-05-22",
              text2: " 알아서들 잘 사용해 보세요 ",
            ),
            ServiceTile(
              text: "스마트홈 신제품 안내",
              text1: "2024-05-09",
              text2: " 사실 신제품 안나옴 ㅋㅋ ",
            ),
            ServiceTile(
              text: "행복한 집 생활 스마트홈!",
              text1: "2024-04-02",
              text2:
                  "행복한 하루 되세요 그리고 행복하세요 행복하고 행복하면 행복이라는 단어가 내 귀에 들어올겁니다 그러니깐 행복하세요 ㅎㅎ ",
            ),
          ],
        ),
      ),
    );
  }
}

class ServiceTile extends StatefulWidget {
  final String text;
  final String text1;
  final String text2;

  const ServiceTile(
      {required this.text,
      required this.text1,
      required this.text2,
      super.key});

  @override
  State<ServiceTile> createState() => _ServiceTileState();
}

class _ServiceTileState extends State<ServiceTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ExpansionTile(
          title: Text(widget.text),
          subtitle: Text(
            widget.text1,
            style: TextStyle(fontSize: 10),
          ),
          children: <Widget>[
            ListTile(
              title: Text(widget.text2),
            )
          ],
        ),
      ],
    );
  }
}

class CustomService extends StatefulWidget {
  const CustomService({super.key});

  @override
  State<CustomService> createState() => _CustomServiceState();
}

class _CustomServiceState extends State<CustomService> {
  bool showNotices = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            style: ElevatedButton.styleFrom(
                minimumSize: Size(150, 150),
                backgroundColor: showNotices ? Color(0xFFE5E5E1) : null,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                showNotices = false;
              });
            },
            child: Text(
              "고객센터",
              style: TextStyle(
                color: Colors.grey,
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
            style: ElevatedButton.styleFrom(
              minimumSize: Size(150, 150),
              backgroundColor: !showNotices ? Color(0xFFE5E5E1) : null,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.zero,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class NoticeTile extends StatefulWidget {
  final String text;
  final String text1;
  final String text2;

  const NoticeTile(
      {required this.text,
      required this.text1,
      required this.text2,
      super.key});

  @override
  State<NoticeTile> createState() => _NoticeTileState();
}

class _NoticeTileState extends State<NoticeTile> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ExpansionTile(
          title: Text(widget.text),
          subtitle: Text(
            widget.text1,
            style: TextStyle(fontSize: 10),
          ),
          children: <Widget>[
            ListTile(
              title: Text(widget.text2),
            )
          ],
        ),
      ],
    );
  }
}




