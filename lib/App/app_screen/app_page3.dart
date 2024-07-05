import 'package:dio/dio.dart' as dio;
import 'package:flutter/material.dart';
import 'package:loginproject/main.dart';

import '../app_screen/bottom_bar.dart';

class AppModifyProfile extends StatefulWidget {
  AppModifyProfile({super.key});

  @override
  State<StatefulWidget> createState() => _AppModifyProfile();
}

class _AppModifyProfile extends State<AppModifyProfile> {
  TextEditingController mbnoController = TextEditingController();
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController pw2Controller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  void initState() {
    super.initState();
    idController.text = user["id"];
    nameController.text = user["name"];
    emailController.text = user["email"];
  }

  @override
  void dispose() {
    mbnoController.dispose();
    idController.dispose();
    pwController.dispose();
    pw2Controller.dispose();
    nameController.dispose();
    emailController.dispose();
    super.dispose();
  }

  void updateProfile() async {
    try {
      final Map<String, dynamic> data = {
        "id": idController.text,
        "pw": pwController.text,
        "pw2": pw2Controller.text,
        "name": nameController.text,
      };
      final dio.Dio dioClient =
          dio.Dio(dio.BaseOptions(baseUrl: "http://192.168.0.177:9090"));
      RegExp passwordRegex = RegExp(
          r'^(?=.*\d)(?=.*[a-zA-Z])(?=.*[~!@#$%^&*(),.?":{}|<>]).{5,12}$');
      if (pwController.text.length > 12 ||
          !passwordRegex.hasMatch(pwController.text)) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('회원 수정 실패'),
              content: const Text('비밀번호는 5자에서 12자 사이이며, 문자와 숫자를 모두 포함해야 합니다.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('확인'),
                ),
              ],
            );
          },
        );
        return;
      }
      dio.Response res = await dioClient.post("/user/update", data: data);
      if (res.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('성공'),
              content: const Text('회원정보가 수정되었습니다.'),
              actions: [
                TextButton(
                  onPressed: () {
                    setState(() {});
                    user = {};
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BottomBar(),
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  child: const Text('확인'),
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
              title: const Text('실패'),
              content: const Text('서버 오류 발생, 다시 시도해 주세요'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const BottomBar()),
                    );
                  },
                  child: const Text('확인'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('회원 수정 실패'),
            content: const Text('비밀번호, 이름을 다시 한번 확인해 주세요'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('확인'),
              ),
            ],
          );
        },
      );
    }
  }

  void cancelChanges() {
    mbnoController.clear();
    idController.clear();
    pwController.clear();
    pw2Controller.clear();
    nameController.clear();
    emailController.clear();
  }

  void deleteAccount() async {
    try {
      final Map<String, dynamic> data = {
        "id": idController.text,
        "pw": pwController.text,
      };

      // 탈퇴 확인 다이얼로그 표시
      bool confirmed = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('경고'),
            content: const Text('정말로 탈퇴하시겠습니까?'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // 취소를 누르면 false 반환
                },
                child: const Text('취소'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // 확인을 누르면 true 반환
                },
                child: const Text('확인'),
              ),
            ],
          );
        },
      );

      // 사용자가 탈퇴를 확인한 경우에만 실제 삭제 작업 실행
      if (confirmed == true) {
        final dio.Dio dioClient =
            dio.Dio(dio.BaseOptions(baseUrl: "http://192.168.0.177:9090"));
        final dio.Response res =
            await dioClient.post("/user/remove", data: data);

        if (res.statusCode == 200 && res.data == true) {
          print(res.data);
          print(res.statusCode);
          setState(() {
            user = {};
          });
          // 사용자 데이터 초기화
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const BottomBar()),
            (Route<dynamic> route) => false,
          );
        } else {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('회원 삭제 실패'),
                content: const Text('아이디와 비밀번호를 다시 한번 확인해 주세요'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('확인'),
                  ),
                ],
              );
            },
          );
        }
      }
    } catch (e) {
      print(e);
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('회원 삭제 실패'),
            content: const Text('서버 오류 발생'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text('확인'),
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
              decoration: const BoxDecoration(
                color: Color(0xFFD3CDC8),
                borderRadius: BorderRadius.vertical(
                  bottom: Radius.circular(30),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 50, bottom: 20),
                child: Row(
                  children: [
                    const Expanded(
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
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Container(
              child: const Text(
                "내 정보",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                ),
              ),
            ),
            const SizedBox(height: 10),
            Container(
              width: double.infinity,
              height: 1.5,
              decoration: const BoxDecoration(color: Colors.black54),
            ),
             SizedBox(height: 30),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [

                    Container(
                      margin: EdgeInsets.only(top: 10),
                      child: SizedBox(
                        width: 300,
                        child: TextField(
                          controller: idController,
                          decoration: const InputDecoration(
                            labelText: "아이디",
                            border: OutlineInputBorder(),
                          ),
                          readOnly: true,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        controller: pwController,
                        decoration: const InputDecoration(
                          labelText: "비밀번호",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      child: TextField(
                        controller: nameController,
                        decoration: const InputDecoration(
                          labelText: "이름",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 300,
                      child: TextFormField(
                        readOnly: true,
                        controller: emailController,
                        decoration: const InputDecoration(
                          labelText: "이메일",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: updateProfile,
                          child: const Text("회원정보수정"),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(50, 50),
                            backgroundColor: const Color(0xFFD3CDC8),
                            textStyle: const TextStyle(fontSize: 18),
                            foregroundColor: Colors.black,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                        const SizedBox(width: 30),
                        const SizedBox(width: 10),
                        ElevatedButton(
                          onPressed: deleteAccount,
                          child: const Text("회원 탈퇴"),
                          style: ElevatedButton.styleFrom(
                            minimumSize: const Size(50, 50),
                            backgroundColor: const Color(0xFFD3CDC8),
                            textStyle: const TextStyle(fontSize: 18),
                            foregroundColor: Colors.black,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
