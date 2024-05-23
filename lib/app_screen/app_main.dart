import "dart:ffi";

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
            padding: const EdgeInsets.only(top: 10, right: 20, left: 20),
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
                SmartText(),
                Row(
                  children: [
                    SmartControl(
                      text: "조명제어",
                      image: "assets/images/lightimage.png",
                        iconButton: IconButton(onPressed: (){},icon: Icon(Icons.power_settings_new_outlined),)
                    ),
                    SmartControl(
                      text: "CCTV",
                      image: "assets/images/cctvimage.png",
                        iconButton: IconButton(onPressed: (){},icon: Icon(Icons.power_settings_new_outlined),)
                    ),
                  ],
                ),
                Row(
                  children: [
                    SmartControl(
                      text: "현관문개폐",
                      image: "assets/images/doorimage.png",
                        iconButton: IconButton(onPressed: (){},icon: Icon(Icons.power_settings_new_outlined),)
                    ),
                    SmartControl(
                      text: "창문개폐",
                      image: "assets/images/windowimage.png",
                        iconButton: IconButton(onPressed: (){},icon: Icon(Icons.power_settings_new_outlined),)
                    ),
                  ],
                ),
                Row(
                  children: [
                    SmartControl(
                      text: "온습도측정",
                      image: "assets/images/homeimage.png",
                      iconButton: IconButton(onPressed: (){},icon: Icon(Icons.power_settings_new_outlined),)
                    ),
                    SmartControl(
                      text: "화재감지",
                      image: "assets/images/fireimage.png",
                      iconButton: IconButton(onPressed: (){

                      },icon: Icon(Icons.power_settings_new_outlined),)
                    ),
                  ],
                )
              ],
            ),
          ),

        ),
      ),
      bottomNavigationBar: BottomNavigationBar(

        items: [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "리스트"),
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "홈"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "내 정보"),
        ],
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
      child: Stack(
        children: [
          Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
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
                )
                .toList(),
            options: CarouselOptions(
                // 화면 전환을 자동으로 할건지 설정
                autoPlay: true,
                //슬라이더가 화면의 비율에 맞춰지도록 합니다.
                aspectRatio: 1.6,
                enlargeCenterPage: true,
                viewportFraction: 1,
                //화면 전환을 몇초마다 할건지 설정함
                autoPlayInterval: Duration(seconds: 5)),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: Text(
                    "Smart Home",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 40,
                    ),
                  ),
                ),
              ),
              Center(
                child: Padding(
                  padding: EdgeInsets.only(top: 0),
                  child: Text(
                    "일상의 행복한 변화",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                ),
              )
            ],
          ),
        ],

      ),

    );
  }
}

class SmartText extends StatefulWidget {
  const SmartText({super.key});

  @override
  State<SmartText> createState() => _SmartTextState();
}

class _SmartTextState extends State<SmartText> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: EdgeInsets.only(top: 20),
          child: const Text(
            "스마트 제어 ",
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold,
                color: Colors.black),
          ),
        ),
      ],
    );
  }
}

class SmartControl extends StatefulWidget {
  final String text;
  final String image;
  final IconButton iconButton;

  const SmartControl({required this.iconButton, required this.image, required this.text, super.key});

  @override
  State<SmartControl> createState() => _SmartControlState();
}

class _SmartControlState extends State<SmartControl> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.all(8),
        padding: const EdgeInsets.all(15),
        height: 90,
        width: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(
            0xFFE5E5E1,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  widget.image,
                  fit: BoxFit.fill,
                ),
                Text(
                  widget.text,
                ),
              ],
            ),
        widget.iconButton,
          ],
        ),
      ),
    );
  }
}


