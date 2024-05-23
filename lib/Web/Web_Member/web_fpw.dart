import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginproject/Web/Web_Member/web_join.dart';
import 'package:loginproject/Web/Web_Member/web_login.dart';
import 'package:loginproject/Web/webmain.dart';

class WebFpw extends StatefulWidget {
  WebFpw({super.key});

  @override
  State<StatefulWidget> createState() => _WebFpwState();
}

class _WebFpwState extends State<WebFpw> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();

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
                      width:400,
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
                            )
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
                        child: Center(
                          child: Text(
                            "비밀번호 찾기",
                            style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold,color: Colors.black),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )


            ]
        ),
      ),
    );
  }
}