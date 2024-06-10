import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AppFid extends StatefulWidget {
  AppFid({super.key});

  @override
  State<StatefulWidget> createState() => _AppFidState();
}

class _AppFidState extends State<AppFid> {
  TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
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
                    controller: name,
                    decoration: InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "이름",
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
                        "아이디찾기",
                        style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                    ),
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
