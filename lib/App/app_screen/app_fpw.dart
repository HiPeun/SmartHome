import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:loginproject/App/app_screen/app_fid.dart';
import 'app_join.dart';
import 'app_npw.dart';

class AppFpw extends StatefulWidget {
  AppFpw({super.key});

  @override
  State<StatefulWidget> createState() => _AppFpwState();
}

class _AppFpwState extends State<AppFpw> {
  TextEditingController id = TextEditingController();
  TextEditingController email = TextEditingController();

  void findPassword(String id, String email) async {
    final dio = Dio();

    try {
      final response = await dio.post(
        "http://192.168.45.63:9090/user/login/pw",
        data: {
          "email": email,
          "id": id,
        },
        options: Options(
          headers: {"Content-Type": "application/json"},
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
            builder: (context) => AppNpw(id: id),
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
        String errorMessage = response.data['message'] ?? "알 수 없는 오류가 발생했습니다.";
        print("비밀번호 찾기 실패: $errorMessage");
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("아이디 또는 이메일 다시 확인해주세요"),
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
      print("비밀번호 찾기 실패: ${e.toString()}");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            content: Text("아이디 또는 이메일 다시 확인해주세요"),
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
                            "계정의 비밀번호를 찾습니다",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                        ],
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
                    width: 300,
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
                    width: 300,
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
                    width: 300,
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
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => AppFid(),
                          ));
                        },
                        child: Text(
                          "아이디 찾기",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 150,
                        height: 50,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context)
                              .pushReplacement(MaterialPageRoute(
                            builder: (context) => AppJoin(),
                          ));
                        },
                        child: Text(
                          "회원가입",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
