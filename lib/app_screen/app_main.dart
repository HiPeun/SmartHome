
import 'package:flutter/material.dart';

void main(){
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
        appBar: AppBar(
          title: Padding(
            padding: const EdgeInsets.fromLTRB(10, 20, 0, 0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  'Conven',
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(150, 0, 0, 10),
                  child: InkWell(
                    onTap: () {
                      print('이미지 백 버튼 클릭 ');
                    },
                    child: Image.asset(
                      'assets/images/backbutton.png',
                      width: 26,
                      height: 26,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 0, 10),
                  child: InkWell(
                    onTap: () {
                      print('회원가입 이미지 클릭 ');
                    },
                    child: Image.asset(
                      'assets/images/personbutton.png',
                      height: 26,
                      width: 26,
                      fit: BoxFit.cover,
                    ),
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

