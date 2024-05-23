import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginproject/Web/Web_Member/web_login.dart';

class WebJoin extends StatefulWidget {
  WebJoin({super.key});

  @override
  State<StatefulWidget> createState() => _WebJoinState();
}

class _WebJoinState extends State<WebJoin> {
  TextEditingController email = TextEditingController();
  TextEditingController pw = TextEditingController();
  TextEditingController pw2 = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController id = TextEditingController();

  bool isAgreed = false;

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
                            "계정을 생성합니다",
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
                        onTap: () {},
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
            Padding(
              padding: const EdgeInsets.only(left: 400, right: 400, top: 100),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    TextField(
                      controller: name,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: '이름',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextField(
                        controller: id,
                        decoration: InputDecoration(
                          prefixIcon: Icon(Icons.key),
                          labelText: '아이디',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: TextField(
                        controller: pw,
                        obscureText: true,
                        decoration: InputDecoration(
                            prefixIcon: Icon(Icons.lock),
                            labelText: "비밀번호",
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
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
                    Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              Checkbox(
                                value: isAgreed,
                                onChanged: (value) {
                                  setState(() {
                                    isAgreed = value!;
                                  });
                                },
                              ),
                              Text(
                                "전체 동의",
                                style: TextStyle(
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          TextButton(
                            onPressed: () {
                              // 약관 동의 페이지로 이동
                            },
                            child: Text(
                              "약관 동의",
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 40),
                      child: ElevatedButton(
                        onPressed: () {
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFD3CDC8),
                          padding: EdgeInsets.symmetric(vertical: 15),
                          fixedSize: Size.fromHeight(45),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        child: Text(
                          "회원가입",
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
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
