import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginproject/App/app_screen/app_join.dart';
import 'package:loginproject/App/app_screen/app_login.dart';

class AppFpw extends StatefulWidget {
  AppFpw({super.key});

  @override
  State<StatefulWidget> createState() => _AppFpwState();
}

class _AppFpwState extends State<AppFpw> {
  TextEditingController _id = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          Container(
            height: 170,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Color(0xFFD3CDC8),
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            child: Row(
              children: [
                Text(
                  "비밀번호 찾기",
                  style: TextStyle(
                    fontSize: 30,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 100,
          ),
          Center(
            child: Column(
              children: [
                SizedBox(
                  width: 300,
                  child: TextField(
                    controller: _id,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "ID",
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(20),
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
                          borderRadius: BorderRadius.circular(20),
                        )),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFD3CDC8),
                  ),
                  margin: EdgeInsets.only(top: 45),
                  width: 300,
                  height: 50,
                  child: InkWell(
                    child: Center(
                      child: Text(
                        "비밀번호 찾기",
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
                  ),
                ),
                Container(
                  child: Row(
                    children: [
                      SizedBox(
                        width: 215,
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => AppLogin()));
                        },
                        child: Text(
                          "로그인",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (BuildContext context) => AppJoin()));
                        },
                        child: Text(
                          "회원가입",
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          )
        ]),
      ),
    );
  }
}
