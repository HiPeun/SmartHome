import 'package:flutter/material.dart';

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
                      onPressed: () {
                        // 회원정보 수정 로직
                      },
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
                      onPressed: () {
                        // 취소 로직
                      },
                      child: Text("취소"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(10, 30),
                        backgroundColor: Color(0xFFE5E5E1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(1),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: () {
                        // 회원탈퇴 로직
                      },
                      child: Text("회원탈퇴"),
                      style: ElevatedButton.styleFrom(
                        minimumSize: Size(10,30),
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
