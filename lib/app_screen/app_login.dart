import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:loginproject/app_screen/app_fpw.dart';

class AppLogin extends StatefulWidget {
  AppLogin({super.key});

  @override
  State<StatefulWidget> createState() => _AppLoginState();
}

class _AppLoginState extends State<AppLogin> {
  final TextEditingController _id = TextEditingController();
  final TextEditingController _pw = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(

          children: [
            Stack(
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
                ),

                Container(
                  child: TextButton(
                    onPressed: () {},
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "로그인",
                          style: TextStyle(
                            fontSize: 40,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 90),
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Color(0xffF9E000),
                ),
                width: 300,
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
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'ID',
                ),
                keyboardType: TextInputType.emailAddress,
                controller: _id,
                obscureText: false,
              ),
            ),
            Container(
              width: 300,
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
              width: 300,
              height: 55,
              child: InkWell(
                child: Center(
                  child: Text(
                    "로 그 인",
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                onTap: () {},
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 35,
                  height: 50,
                ),
                Container(
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "아이디 찾기",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                Container(
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => AppFpw(),
                      ));
                    },
                    child: Text(
                      "비밀번호 찾기",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: 10,
                ),
                Container(
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "회원가입",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
