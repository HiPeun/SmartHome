import "dart:async";

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
                ),
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
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(20)),
            CarouselSlider(
              items: imgList
                  .map(
                    (e) => Container(
                      child: Image.asset(
                        e,
                        fit: BoxFit.cover,
                        width: 50,
                      ),
                    ),
                  )
                  .toList(),
              options: CarouselOptions(
                  autoPlay: true,  //자연스럽게 넘어 가는 기능
                  aspectRatio: 2.0, //
                  enlargeCenterPage: true,
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
