
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:loginproject/Web/webmain.dart';
import '../Web_Cus/web_notice.dart';
import 'globals.dart';

class WebModifyProfile extends StatefulWidget {
  WebModifyProfile({super.key });

  @override
  State<StatefulWidget> createState() => _WebModifyProfile();
}

class _WebModifyProfile extends State<WebModifyProfile> {
  TextEditingController idController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController pw2Controller = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController= TextEditingController();
  TextEditingController mbnoController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    pwController.dispose();
    pw2Controller.dispose();
    nameController.dispose();
    emailController.dispose();
    mbnoController.dispose();
    idController.dispose();
    super.dispose();
  }

  Future<void> searchById() async {
    final String url = 'http://192.168.0.177:9090/user/login/info';
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'mbno': int.tryParse(mbnoController.text) ?? 0,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      setState(() {
        idController.text = data['id'] ?? 'N/A';
        nameController.text = data['name'] ?? 'N/A';
        emailController.text = data['email'] ?? 'N/A';
      });
    } else {
      // 에러 처리
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('조회 실패: ${response.reasonPhrase}')),
      );
    }
  }
  Future<void> updateProfile() async {
    final String url = 'http://192.168.0.177:9090/user/update';
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'pw': pwController.text,
        'name': nameController.text,
        'mbno': int.tryParse(mbnoController.text) ?? 0,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('회원정보 수정 완료')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('수정 실패: ${response.reasonPhrase}')),
      );
    }
  }

  Future<void> deleteAccount() async {
    final String url = 'http://192.168.0.177:9090/user/remove';
    final response = await http.post(
      Uri.parse(url),
      headers: <String, String>{
        'Content-Type': 'application/json',
      },
      body: jsonEncode(<String, dynamic>{
        'id': idController.text,
        'pw': pwController.text,
      }),
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('계정 삭제 완료')),
      );
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) => MyApp(),
      ));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('삭제 실패: ${response.reasonPhrase}')),
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
                            builder: (context) => WebModifyProfile(
                              ),
                          ));
                        },
                        child: Text("내 정보",
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
                        controller: mbnoController,
                        decoration: InputDecoration(
                          labelText: "mbno",
                          border: OutlineInputBorder(),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: searchById,
                      child: Text("아이디 조회"),
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
                    SizedBox(height: 16),
                    SizedBox(
                      width: 600,
                      child: TextField(
                        controller: idController,
                        enabled: false,
                        decoration: InputDecoration(
                          labelText: "아이디",
                          border: OutlineInputBorder(),
                        ),
                        readOnly: true,
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
                        readOnly: true,
                      ),
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      width: 600,
                      child: TextField(
                        controller: emailController,
                        decoration: InputDecoration(
                          labelText: "이메일",
                          border: OutlineInputBorder(),
                        ),
                        readOnly: true,
                      ),
                    ),
                    SizedBox(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
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
                        ElevatedButton(
                          onPressed: () {},
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
                        ElevatedButton(
                          onPressed: () {},
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
