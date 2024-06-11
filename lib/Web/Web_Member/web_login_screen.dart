import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:loginproject/Web/Web_Cus/web_notice.dart';
import 'package:loginproject/Web/Web_Cus/web_notice_screen.dart';
import 'package:loginproject/Web/Web_Member/web_join.dart';
import 'package:loginproject/Web/Web_Member/web_login.dart';
import 'package:loginproject/Web/Web_Member/web_modify_profile.dart';
import 'package:loginproject/Web/webmain.dart';



class WebLoginScreen extends StatefulWidget {
  const WebLoginScreen({super.key, required this.title});

  final String title;

  @override
  State<WebLoginScreen> createState() => _WebLoginScreenState();
}


class _WebLoginScreenState extends State<WebLoginScreen> {
  bool isLogin = false;

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
                    const Expanded(
                      child: Text(
                        "Conven",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 50,
                          color: Color(0xFF2C2B28),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: Container(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(builder: (context) => const MyHomePage(),
                            ));
                          },

                          child: const Text(
                            "로그아웃",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: Container(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => WebModifyProfile(),
                            ));
                          },
                          child: const Text(
                            "내 정보",
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: Container(
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => WebNoticeScreen(),
                            ));
                          },
                          child: const Text(
                            "고객센터",
                            style: TextStyle(
                              fontSize: 20,
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
                  Padding(
                    padding: const EdgeInsets.only(top: 30),
                    child: CarouselSlider.builder(
                      itemCount: imgList.length,
                      itemBuilder: (BuildContext context, int itemIndex,
                          int pageViewIndex) =>
                          Container(
                            child: Image.network(imgList[itemIndex],
                                fit: BoxFit.cover),
                          ),
                      options: CarouselOptions(
                        height: 500,
                        // 슬라이더의 높이를 지정
                        viewportFraction: 1.0,
                        // 사진을 하나하나 보여줌
                        initialPage: 0,
                        // 0번부터
                        enableInfiniteScroll: true,
                        // 스크롤
                        autoPlay: true,
                        // 자동 플레이
                        autoPlayCurve: Curves.fastOutSlowIn,
                        // 자동 재생 애니메이션 커브 설정
                        scrollDirection: Axis.horizontal, // 스크롤 방향을 가로로 설정
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 180),
                            child: const Text(
                              "Smart Home",
                              style: TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          Container(
                            child: const Text(
                              "일상의 행복한 변화",
                              style:
                              TextStyle(fontSize: 40, color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(top: 100),
                        child: Container(
                          child: const Text(
                            "당신의 일상을 더 똑똑하고 편리하게 바꿔보세요",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: const Text(
                          "누구 스마트홈 앱 하나로 언제 어디서나 가전제품은 물론, 우리집 안팎 곳곳을 컨트롤할 수 있습니다.",
                          style: TextStyle(fontSize: 15, color: Colors.grey),
                        ),
                      )
                    ],
                  ),
                ],
              ),
              Stack(
                children: [
                  Center(
                    child: Container(
                      child: Image.asset(
                        "assets/webmain/light.png",
                        width: 1200,
                        height: 800,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 300),
                            child: const Text(
                              "조명 제어",
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C2B28),
                              ),
                            ),
                          ),
                          Container(
                            child: const Text(
                              "우리집 조명 어디서든 제어 할 수 있어요",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C2B28),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              Stack(
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: Image.asset(
                        "assets/webmain/CCTV.png",
                        width: 1200,
                        height: 800,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 350),
                            child: const Text(
                              "CCTV 확인",
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C2B28),
                              ),
                            ),
                          ),
                          Container(
                            child: const Text(
                              "언제 어디서든 집 확인 서비스",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C2B28),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              Stack(
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: Image.asset(
                        "assets/webmain/temperature.png",
                        width: 1200,
                        height: 800,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 350),
                            child: const Text(
                              "온 습도 확인",
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C2B28),
                              ),
                            ),
                          ),
                          Container(
                            child: const Text(
                              "따뜻한 환경 유지 서비스",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C2B28),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              Stack(
                children: [
                  Center(
                    child: Container(
                      margin: const EdgeInsets.only(top: 50),
                      child: Image.asset(
                        "assets/webmain/window.png",
                        width: 1200,
                        height: 800,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: const EdgeInsets.only(top: 350),
                            child: const Text(
                              "창문 개폐 서비스",
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C2B28),
                              ),
                            ),
                          ),
                          Container(
                            child: const Text(
                              "쾌적한 우리집을 만들어 봐요",
                              style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C2B28),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),

              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Container(
                      child: InkWell(
                          onTap: () {},
                          child: const Text(
                            "이용약관",
                            style: TextStyle(color: Colors.grey),
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 50),
                    child: Container(
                      child: InkWell(
                        onTap: () {},
                        child: const Text(
                          "개인정보 처리방침",
                          style: TextStyle(color: Colors.grey),
                        ),
                      ),
                    ),
                  )
                ],
              ),
              const Padding(
                padding: EdgeInsets.only(left: 50),
                child: Row(
                  children: [
                    Text(
                      "• 대표이사/사장 김근재",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 50),
                child: Row(
                  children: [
                    Text(
                      "• 광주 북구 북문대로242번길 11",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 50),
                child: Row(
                  children: [
                    Text(
                      "• 고객센터 010-8805-4754",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
              const Padding(
                padding: EdgeInsets.only(left: 50, bottom: 30),
                child: Row(
                  children: [
                    Text(
                      "• COPYRIGHT ⓒ 럽팅",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}