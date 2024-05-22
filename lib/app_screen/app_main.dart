import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
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
    return Scaffold(
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 20, right: 20, left: 20),
            child: Column(
              children: [
                Row(
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
                    Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: InkWell(
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
                      ),
                    ),
                  ],
                ),
                AppMainView(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class AppMainView extends StatefulWidget {
  const AppMainView({super.key});

  @override
  State<AppMainView> createState() => _AppMainViewState();
}

class _AppMainViewState extends State<AppMainView> {
  // 이미지 슬라이더 list로 묶음
  final List<String> imgList = [
    'assets/webmain/webmain1.png',
    'assets/webmain/webmain2.png',
    'assets/webmain/webmain3.png',
    'assets/webmain/webmain4.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Padding(padding: EdgeInsets.fromLTRB(0, 30, 0, 0)),
          CarouselSlider(
            items: imgList
                .map(
                  (e) => Container(
                    child: Image.asset(
                      e,
                      fit: BoxFit.cover,
                      width: 1000,
                    ),
                  ),
                ).toList(),
            options: CarouselOptions(
              autoPlay: true, // 화면 전환을 자동으로 할건지 설정
              aspectRatio: 1.6, //슬라이더가 화면의 비율에 맞춰지도록 합니다.
              enlargeCenterPage: true,
              viewportFraction: 1,
              autoPlayInterval: Duration(seconds: 3) //화면 전환을 몇초마다 할건지 설정함
            ),
          ),
        ],
      ),
    );
  }
}
