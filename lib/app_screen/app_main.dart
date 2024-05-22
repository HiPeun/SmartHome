import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

void main() {
  runApp(const AppMain());
}

class AppMain extends StatefulWidget {
  const AppMain({super.key});

  @override
  State<AppMain> createState() => _AppMainState();
}

class _AppMainState extends State<AppMain> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    "Conven",
                    style: TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/backbutton.png",
                        width: 26,
                        height: 26,
                        fit: BoxFit.cover,
                      ),
                      Text("로그인"),
                    ],
                  ),
                ),

                InkWell(
                  onTap: () {},
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/personbutton.png",
                        width: 26,
                        height: 26,
                        fit: BoxFit.cover,
                      ),
                      Text("회원가입"),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
