
import 'package:flutter/material.dart';
import 'package:loginproject/Web/Web_Member/web_join.dart';
import 'package:loginproject/Web/Web_Member/web_login.dart';
import 'package:loginproject/Web/webmain.dart';

import '../Web_Cus/web_notice.dart';

class WebModifyProfile extends StatefulWidget {
  WebModifyProfile({super.key});

  @override
  State<StatefulWidget> createState() => _WebModifyProfile();
}

class _WebModifyProfile extends State<WebModifyProfile> {
  TextEditingController id = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController pw2Controller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  void dispose() {
    pwController.dispose();
    pw2Controller.dispose();
    nameController.dispose();
    super.dispose();
  }

  @override
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
                            "내 정보를 수정합니다",
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
                            builder: (context) => MyApp(),
                          ));
                        },
                        child: Text(
                          "로그아웃",
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
                            builder: (context) => WebModifyProfile(),
                          ));
                        },
                        child: Text(
                            "내 정보",
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
                    "내 정보",
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
                SizedBox(height: 50),
                Expanded(
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 600,
                            child: TextField(
                              controller: id,
                              decoration: InputDecoration(
                                labelText: "아이디",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          SizedBox(
                            width: 600,
                            child: TextField(
                              controller: pwController,
                              decoration: InputDecoration(
                                labelText: "비밀번호",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          SizedBox(
                            width: 600,
                            child: TextField(
                              controller: pw2Controller,
                              decoration: InputDecoration(
                                labelText: "비밀번호 확인",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          SizedBox(
                            width: 600,
                            child: TextField(
                              controller: nameController,
                              decoration: InputDecoration(
                                labelText: "이름",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),
                          SizedBox(height: 16),
                          SizedBox(
                            width: 600,
                            child: TextField(
                              controller: email,
                              decoration: InputDecoration(
                                labelText: "이메일",
                                border: OutlineInputBorder(),
                              ),
                            ),
                          ),

                          SizedBox(height: 20),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(onPressed: () {},
                                  child: Text("회원정보수정"),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(100, 50),
                                  backgroundColor: Color(0xFFD3CDC8),
                                  textStyle: TextStyle(fontSize: 18),
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(onPressed: () {},
                                child: Text("취소"),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(100, 50),
                                  backgroundColor: Color(0xFFD3CDC8),
                                  textStyle: TextStyle(fontSize: 18),
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ),
                              ),
                              SizedBox(width: 10),
                              ElevatedButton(onPressed: () {},
                                child: Text("회원 탈퇴"),
                                style: ElevatedButton.styleFrom(
                                  minimumSize: Size(100, 50),
                                  backgroundColor: Color(0xFFD3CDC8),
                                  textStyle: TextStyle(fontSize: 18),
                                  foregroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ),
                              ),
                            ],
                          )

                        ],
                      )
                    ),
                ),
            ],
          ),
        ),
      );
  }
}