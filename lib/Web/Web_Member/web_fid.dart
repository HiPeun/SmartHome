import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginproject/Web/Web_Member/web_join.dart';
import 'package:loginproject/Web/Web_Member/web_login.dart';

class WebFid extends StatefulWidget {
  WebFid({super.key});

  @override
  State<StatefulWidget> createState() => _WebFidState();
}

class _WebFidState extends State<WebFid> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();

  void findId(String name, String email) async {
    final dio = Dio();

    try {
      final response = await dio.post(
        "http://192.168.0.188:9090/user/login/findid",
        data: {
          "email": email,
          "name": name,
        },
        options: Options(
          headers: {
            "Content-Type": "application/json"
          },
        ),
      );
      print(response.data);

      if (response.statusCode == 200) {
        String? id = response.data['id']; // null 값을 처리
        if (id != null && id.isNotEmpty) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("아이디 찾기 성공!\n아이디: $id"),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => WebLogin(),
                          ));
                    },
                    child: Text('확인'),
                  ),
                ],
              );
            },
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("아이디를 찾을 수 없습니다. 다시 시도해 주세요."),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // 알림 닫기
                    },
                    child: Text('확인'),
                  ),
                ],
              );
            },
          );
        }
      } else {
        String errorMessage = response.data['message'] ?? "알 수 없는 오류가 발생했습니다.";
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("아이디 찾기 실패: $errorMessage"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // 알림 닫기
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
            content: Text("아이디 찾기 실패: ${e.toString()}"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // 알림 닫기
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
                            "계정의 아이디를 찾습니다",
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
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: InkWell(
                        onTap: () {},
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
            SizedBox(
              height: 100,
            ),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 400,
                    child: TextField(
                      controller: name,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: "이름",
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
                      color: Color(0xFFD3CDC8),
                    ),
                    margin: EdgeInsets.only(top: 45),
                    width: 400,
                    height: 50,
                    child: InkWell(
                      onTap: () {
                        findId(name.text, email.text);
                      },
                      child: Center(
                        child: Text(
                          "아이디 찾기",
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
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
