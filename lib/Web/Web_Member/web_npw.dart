import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginproject/main.dart';
import 'package:loginproject/Web/Web_Member/web_join.dart';
import 'package:loginproject/Web/Web_Member/web_login.dart';

class WebNpw extends StatefulWidget {
  final String id;
  WebNpw({Key? key, required this.id}) : super(key: key);


  @override
  State<StatefulWidget> createState() => _WebNpwState();
}

class _WebNpwState extends State<WebNpw> {
  late String id;
  TextEditingController pw = TextEditingController();
  TextEditingController pw2 = TextEditingController();



  void initState(){
    //super.initState 코드는 현재 클래스에서 오버라이드 된
    // initState() 메서드 내에서 상위 클래스의 initState() 메서드를 호출
    super.initState();
    id = widget.id; // 생성자에서 받아온 id 값을 초기화
    pw = TextEditingController(text: "");
    pw2 = TextEditingController(text: "");
  }
//각 텍스트 필드의 입력값을 Controller를 사용하여 가져오고
// dispose을 사용해서 메모리 누수를 방지
  @override
  void dispose(){
    pw.dispose();
    pw2.dispose();
    //super.dispose를 호출하여 부모 클래스의 dispose 메소드를 실행하여 추가적인 정리 작업을 수행
    super.dispose();
  }

  void updatePassword() async {
    final dio = Dio();
    try {
      final response = await dio.post(
        "http://192.168.0.177:9090/user/login/pwfind",
        data: {
          'id': id,
          'pw': pw.text,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      RegExp passwordRegex = RegExp(r'^(?=.*\d)(?=.*[a-zA-Z])(?=.*[~!@#$%^&*(),.?":{}|<>]).{5,12}$');
      if (pw.text.length > 12 || !passwordRegex.hasMatch(pw.text)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("비밀번호는 5자에서 12자 사이이며, 문자와 숫자를 모두 포함해야 합니다."),
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
        return;
      }

      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("비밀번호 수정이 완료되었습니다. 로그인 페이지로 이동합니다."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WebLogin(),
                    ));
                  },
                  child: Text('확인'),
                ),
              ],
            );
          },
        );
      } else {
        print("비밀번호 수정 실패: ${response.data}");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("비밀번호 수정에 실패했습니다. 다시 시도해주세요."),
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
      print("비밀번호 수정 실패: $e");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("비밀번호 수정에 실패했습니다. 다시 시도해주세요."),
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
                            "비밀번호를 변경합니다",
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
                  ],
                ),
              ),
            ),
            SizedBox(height: 100),
            Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 400,
                    child: TextField(
                      controller: pw,
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: "새 비밀번호",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10)
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 400,
                    child: TextField(
                      controller: pw2,
                      obscureText: true,
                      decoration: InputDecoration(
                          prefixIcon: Icon(Icons.lock),
                          labelText: "비밀번호 확인",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          )
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: const Color(0xFFD3CDC8),
                      child: MaterialButton(
                        onPressed: () {
                          String newPassword = pw.text;
                          String newPassword2 = pw2.text;

                          if (newPassword != newPassword2) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text("비밀번호가 일치하지 않습니다."),
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
                            return;
                          }

                          RegExp passwordRegex = RegExp(r'^(?=.*\d)(?=.*[a-zA-Z]).{5,12}$');
                          if (!passwordRegex.hasMatch(newPassword)) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text("비밀번호는 5자에서 12자 사이이며, 문자와 숫자를 모두 포함해야 합니다."),
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
                            return;
                          }

                          updatePassword();
                        },
                        child: SizedBox(
                          width: 400,
                          height: 45,
                          child: Center(
                            child: Text(
                              "비밀번호 수정하기",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}