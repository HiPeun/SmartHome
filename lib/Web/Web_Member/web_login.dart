import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginproject/Web/Web_Cus/web_notice.dart';
import 'package:loginproject/Web/Web_Member/web_fid.dart';
import 'package:loginproject/Web/Web_Member/web_fpw.dart';
import 'package:loginproject/Web/Web_Member/web_join.dart';
import 'package:loginproject/Web/webmain.dart';

class WebLogin extends StatefulWidget {
  WebLogin({super.key});

  @override
  State<StatefulWidget> createState() => _WebLoginState();
}

class _WebLoginState extends State<WebLogin> {
  final TextEditingController _id = TextEditingController();
  final TextEditingController _pw = TextEditingController();

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
                            "계정을 로그인 합니다",
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
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebNotice(),
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
            Padding(
              padding: const EdgeInsets.only(top: 90),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffF9E000),
                ),
                width: 400,
                height: 55,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                      child: Image.asset(
                        "assets/images/kakao.png",
                        width: 30,
                        height: 30,
                      ),
                    ),
                    Container(
                      child: Text(
                        "카카오톡으로 시작하기",
                        style: TextStyle(
                          fontSize: 19,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 10,
                      height: 10,
                    )
                  ],
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: 400,
              child: TextField(
                decoration: InputDecoration(labelText: 'ID'),
                keyboardType: TextInputType.emailAddress,
                controller: _id,
                obscureText: false,
              ),
            ),
            Container(
              width: 400,
              child: TextField(
                maxLength: 10,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                keyboardType: TextInputType.emailAddress,
                controller: _pw,
                obscureText: true,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFFD3CDC8),
              ),
              margin: EdgeInsets.only(top: 20),
              width: 400,
              height: 55,
              child: InkWell(
                child: Center(
                  child: Text(
                    "로 그 인",
                    style: TextStyle(fontSize: 19, fontWeight: FontWeight.bold,color: Colors.black),
                  ),
                ),
                onTap: () {},
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right:120, top: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => WebJoin(),
                      ));
                    },
                    child: Text(
                      "회원가입",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: InkWell(
                    child: Text(
                      "아이디 찾기",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => WebFid(),
                      ));
                    },
                  ),
                  ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: InkWell(
                    child: Text(
                      " 비밀번호 찾기",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => WebFpw(),
                      ));
                    },
                ),
                ),
              ],
            )
          ],
        ),

      ),
    );
  }
}
