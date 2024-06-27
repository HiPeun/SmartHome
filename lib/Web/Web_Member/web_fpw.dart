import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginproject/main.dart';
import 'package:loginproject/Web/Web_Member/web_join.dart';
import 'package:loginproject/Web/Web_Member/web_login.dart';
import 'package:loginproject/Web/Web_Member/web_npw.dart';
import 'package:loginproject/Web/webmain.dart';

class WebFpw extends StatefulWidget {
  WebFpw({super.key});

  @override
  State<StatefulWidget> createState() => _WebFpwState();
}

class _WebFpwState extends State<WebFpw> {
  TextEditingController id = TextEditingController();
  TextEditingController email = TextEditingController();

  void findPassword(String id, String email) async {
    if (id.isEmpty || email.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("아이디 또는 이메일을 입력해주세요."),
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
      return; // 이후 코드 실행을 막음
    }

    final dio = Dio();

    try {
      final response = await dio.post(
        "http://192.168.0.177:9090/user/login/pw",
        data: {
          "email": email,
          "id": id,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json"
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );
      print(response.data);
      if (response.statusCode == 200) {
        if (response.data == true) {
          print('ID: $id');
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => WebNpw(id: id),
          ));
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("입력한 정보가 정확한지 확인하세요."),
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
        }
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("비밀번호 찾기 실패"),
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
      }
    } catch (e) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("아이디 및 이메일을 다시 한번 확인해주세요"),
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
                color: Color(0xFFe6e8ed),
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
                          InkWell(
                            onTap: () {
                              Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => MyHomePage(),
                              ));
                            },
                            child: Text(
                              "Conven",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 50,
                                color: Color(0xFF56648b), // 추가: 글자 색상
                              ),
                            ),
                          ),
                          Text(
                            "계정의 비밀번호를 찾습니다",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
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
                  ],
                ),
              ),
            ),
            SizedBox(
                height: 100),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 400,
                    child: TextField(
                      controller: id,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "아이디",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 400,
                    child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.markunread_rounded),
                        labelText: "이메일",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xFF6489e9),
                    ),
                    margin: EdgeInsets.only(top: 45),
                    width: 400,
                    height: 50,
                    child: InkWell(
                      onTap: () {
                        findPassword(id.text, email.text);
                      },
                      child: Center(
                        child: Text(
                          "비밀번호 찾기",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.normal,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}


