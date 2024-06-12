import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:loginproject/Web/Web_Cus/web_notice.dart';
import 'package:loginproject/Web/Web_Member/web_join.dart';
import 'package:loginproject/Web/Web_Member/web_login.dart';
import 'package:loginproject/Web/Web_Member/web_modify_profile.dart';

import '../App/main.dart';


class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
                          fontSize: 50,
                          color: Color(0xFF2C2B28),
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: Container(
                        child: InkWell(
                          onTap: () async {
                            if (user.isEmpty) {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WebLogin()),
                              );
                            } else {
                              user = {};
                            }
                            setState(() {});
                          },
                          child: Text(
                            // isEmpty 빈값이면
                            user.isEmpty ? '로그인' : '로그아웃',
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
                          onTap: () async {
                            if (user.isEmpty) {
                              await Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WebJoin()),
                              );
                            } else {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => WebModifyProfile()),
                              );
                            }
                          },
                          child: Text(
                            user.isEmpty ? '회원가입' : '내 정보',
                            style: TextStyle(
                              fontSize: 20,
                            ),
                          ),
                        ),
                      ),
                    ),
                    if (user.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(right: 40),
                        child: Container(
                          child: InkWell(
                            onTap: () async {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => WebNotice(),
                                  ));
                            },
                            child: Text(
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
                        viewportFraction: 1.0,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Container(
                            margin: EdgeInsets.only(top: 180),
                            child: Text(
                              "Smart Home",
                              style: TextStyle(
                                  fontSize: 80,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                          ),
                          Container(
                            child: Text(
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
                          child: Text(
                            "당신의 일상을 더 똑똑하고 편리하게 바꿔보세요",
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      Container(
                        child: Text(
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
                            margin: EdgeInsets.only(top: 300),
                            child: Text(
                              "조명 제어",
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C2B28),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
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
                            margin: EdgeInsets.only(top: 300),
                            child: Text(
                              "CCTV 확인",
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C2B28),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
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
                            margin: EdgeInsets.only(top: 300),
                            child: Text(
                              "온 습도 확인 서비스",
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C2B28),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "따뜻한 집 환경 확인 서비스",
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
                            margin: EdgeInsets.only(top: 300),
                            child: Text(
                              "창문 개폐 서비스",
                              style: TextStyle(
                                fontSize: 50,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF2C2B28),
                              ),
                            ),
                          ),
                          Container(
                            child: Text(
                              "쾌적한 우리집 환경을 만들어 봐요",
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
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: Row(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: 100),
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "이용약관",
                          style:
                              TextStyle(fontSize: 20, color: Color(0xFFE5E5E1)),
                        ),
                      ),
                    ),
                    Container(
                      width: 200,
                    ),
                    Container(
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          "개인정보 처리방침",
                          style:
                              TextStyle(fontSize: 20, color: Color(0xFFE5E5E1)),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 100),
                          child: Text(
                            "대표이사/사장 김근재",
                            style: TextStyle(color: Color(0xFFE5E5E1)),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 100),
                        child: Text(
                          "광주 북구 북문대로242번길 11",
                          style: TextStyle(color: Color(0xFFE5E5E1)),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                          margin: EdgeInsets.only(left: 100),
                          child: Text(
                            "고객센터 010-8805-4754",
                            style: TextStyle(color: Color(0xFFE5E5E1)),
                          )),
                    ],
                  ),
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.only(left: 100),
                        child: Text(
                          "COPYRIGHT ⓒ 럽팅",
                          style: TextStyle(color: Color(0xFFE5E5E1)),
                        ),
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
