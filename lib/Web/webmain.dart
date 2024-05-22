import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SmartHome',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Smart Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
      body: SafeArea(
        top: true,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 30),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        "Conven",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 60,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: Container(
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            "로그인",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: Container(
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            "회원가입",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: Container(
                        child: InkWell(
                          onTap: () {},
                          child: Text(
                            "고객센터",
                            style: TextStyle(
                              fontSize: 25,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // 이미지 슬라이더
              Stack(
                children: [
                  CarouselSlider.builder(
                    itemCount: imgList.length,
                    itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                        Container(
                          child: Image.network(imgList[itemIndex], fit: BoxFit.cover),
                        ),
                    options: CarouselOptions(
                      height: 500, // 슬라이더의 높이를 지정
                      viewportFraction: 1.0, // 사진을 하나하나 보여줌
                      initialPage: 0, // 0번부터
                      enableInfiniteScroll: true, // 스크롤
                      autoPlay: true, // 자동 플레이
                      autoPlayCurve: Curves.fastOutSlowIn, // 자동 재생 애니메이션 커브 설정
                      scrollDirection: Axis.horizontal, // 스크롤 방향을 가로로 설정
                    ),
                  ),
                ],

              ),
            ],
          ),
        ),
      ),
    );
  }
}
