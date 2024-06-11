import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:get/get.dart';
import 'dart:convert';

import 'package:loginproject/App/app_screen/app_login.dart';
import 'package:loginproject/App/app_screen/bottom_bar.dart';
import 'package:loginproject/App/main.dart';

class Page3 extends StatefulWidget {
  const Page3({
    Key? key,
  }) : super(key: key);

  @override
  State<Page3> createState() => _Page3State();
}

class _Page3State extends State<Page3> {
  TextEditingController email = TextEditingController();
  TextEditingController pw = TextEditingController();
  TextEditingController pw2 = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController id = TextEditingController();

  bool isPwMatched = false;
  String mbno = '';

  @override
  void initState() {
    super.initState();

    try {
      if (user.isNotEmpty) {
        
        email.text = user['email'] ?? '';
        name.text = user['name'] ?? '';
        id.text = user['id'] ?? '';
        mbno = user['mbno'].toString();
      }
    } catch (e) {
      print('Error parsing userData: $e');
    }
  }

  Future<void> checkPasswords() async {
    if (pw.text != pw2.text) {
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
      var response = await Dio().post(
        'http://177.29.112.112:9090/user/login',
        data: {
          'id': id.text,
          'pw': pw.text,
        },
      );
      if (response.statusCode == 200) {
        setState(() {
          isPwMatched = true;
        });
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('오류'),
              content: Text('비밀번호가 올바르지 않습니다.'),
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
      print('Error checking password: $e');
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('오류'),
            content: Text('비밀번호 확인 중 오류가 발생했습니다.'),
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

  Future<void> updateUserInfo() async {
    if (!isPwMatched) return;

    try {
      var response = await Dio().post(
        'http://177.29.112.112:9090/user/update',
        data: {
          'name': name.text,
          'email': email.text,
          'mbno': int.parse(mbno),
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
      var response = await Dio().post(
        'http://177.29.112.112:9090/user/remove',
        data: {
          'id': id.text,
          'pw': pw.text,
        },
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
                    Navigator.of(context).push(MaterialPageRoute(
                        builder: (BuildContext context) => BottomBar()));
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
        child: user.isEmpty ? _buildUserInfoForm() : _buildLoginPrompt(),
      ),
    );
  }

  Widget _buildUserInfoForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
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
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.zero),
              ),
            ),
          ],
        ),
        SizedBox(height: 40),
        Container(
          width: double.infinity,
          height: 10,
          color: Color(0xFFE5E5E1),
        ),
        SizedBox(height: 10),
        TextField(
          controller: id,
          decoration: InputDecoration(labelText: "아이디"),
          //읽기전용 모드
          readOnly: true,
        ),
        TextField(
          controller: pw,
          decoration: InputDecoration(labelText: "비밀번호"),
          obscureText: true,
        ),
        TextField(
          controller: pw2,
          decoration: InputDecoration(labelText: "비밀번호 확인"),
          obscureText: true,
        ),
        SizedBox(height: 20),
        ElevatedButton(
          onPressed: checkPasswords,
          child: Text("비밀번호 확인"),
          style: ElevatedButton.styleFrom(
            minimumSize: Size(10, 30),
            backgroundColor: Color(0xFFE5E5E1),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(1),
            ),
          ),
        ),
        SizedBox(height: 20),
        TextField(
          controller: name,
          decoration: InputDecoration(labelText: "이름"),
          enabled: isPwMatched,
        ),
        TextField(
          controller: email,
          decoration: InputDecoration(labelText: "이메일"),
          enabled: isPwMatched,
        ),
        SizedBox(height: 20),
        Container(
          width: double.infinity,
          height: 10,
          color: Color(0xFFE5E5E1),
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: isPwMatched ? updateUserInfo : null,
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
                  borderRadius: BorderRadius.circular(1),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLoginPrompt() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("로그인이 필요합니다.", style: TextStyle(fontSize: 18)),
          SizedBox(height: 20),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AppLogin()),
              );
            },
            child: Text("로그인 페이지로 이동"),
          ),
        ],
      ),
    );
  }
}
