import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

class Page3 extends StatefulWidget {
  const Page3({super.key});

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  TextEditingController email = TextEditingController();
  TextEditingController pw = TextEditingController();
  TextEditingController pw2 = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController id = TextEditingController();

  Future<void> updateUserInfo() async {
    if (pw.text != pw2.text) {
      // 비밀번호가 일치하지 않음
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('오류'),
            content: Text('비밀번호가 일치하지 않습니다.'),
            actions: [
              TextButton(
                child: Text('확인'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      var response = await Dio().put(
        'http://192.168.0.177:9090/user/update${id.text}',
        data: {
          'email': email.text,
          'password': pw.text,
          'name': name.text,
        },
      );
      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('성공'),
              content: Text('회원정보가 수정되었습니다.'),
              actions: [
                TextButton(
                  child: Text('확인'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
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
              title: Text('오류'),
              content: Text('회원정보 수정에 실패했습니다.'),
              actions: [
                TextButton(
                  child: Text('확인'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error updating user info: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('오류'),
            content: Text('회원정보 수정 중 오류가 발생했습니다.'),
            actions: [
              TextButton(
                child: Text('확인'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> deleteUser() async {
    try {
      var response = await Dio().delete(
        'http://192.168.0.177:9090/user/remove${id.text}',
      );
      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('성공'),
              content: Text('회원탈퇴가 완료되었습니다.'),
              actions: [
                TextButton(
                  child: Text('확인'),
                  onPressed: () {
                    Navigator.of(context).pop();
                    // 탈퇴 후 메인 페이지 등으로 이동
                    Navigator.of(context).pushReplacementNamed('/page1');
                  },
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
              title: Text('오류'),
              content: Text('회원탈퇴에 실패했습니다.'),
              actions: [
                TextButton(
                  child: Text('확인'),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      print('Error deleting user: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('오류'),
            content: Text('회원탈퇴 중 오류가 발생했습니다.'),
            actions: [
              TextButton(
                child: Text('확인'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 10,
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: ElevatedButton(
                    onPressed: () {},
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/pencil.png"),
                        Text(
                          "회원정보 수정",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                    style: ElevatedButton.styleFrom(
                      minimumSize: Size(150, 150),
                      backgroundColor: Color(0xFFE5E5E1),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.zero),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: double.infinity,
              height: 40,
            ),
            Container(
              width: double.infinity,
              height: 10,
              color: Color(0xFFE5E5E1),
            ),
            SizedBox(
              width: double.infinity,
              height: 10,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: id,
                  decoration: InputDecoration(
                    labelText: "아이디",
                  ),
                ),
                TextField(
                  controller: pw,
                  decoration: InputDecoration(
                    labelText: "비밀번호",
                  ),
                  obscureText: true,
                ),
                TextField(
                  controller: pw2,
                  decoration: InputDecoration(
                    labelText: "비밀번호 확인",
                  ),
                  obscureText: true,
                ),
                TextField(
                  controller: name,
                  decoration: InputDecoration(
                    labelText: "이름",
                  ),
                ),
                TextField(
                  controller: email,
                  decoration: InputDecoration(
                    labelText: "이메일",
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  width: double.infinity,
                  height: 10,
                  color: Color(0xFFE5E5E1),
                ),
                SizedBox(
                  width: double.infinity,
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                      onPressed: updateUserInfo,
                      child: Text("회원정보수정"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(10, 30),
                        backgroundColor: Color(0xFFE5E5E1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: deleteUser,
                      child: Text("회원탈퇴"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(10, 30),
                        backgroundColor: Color(0xFFE5E5E1),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(1)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
