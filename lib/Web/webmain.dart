import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:loginproject/Web/Web_Cus/web_notice.dart';
import 'package:loginproject/Web/Web_Member/web_join.dart';
import 'package:loginproject/Web/Web_Member/web_login.dart';
import 'package:loginproject/Web/Web_Member/web_login_screen.dart';

import 'Web_Member/user_controller.dart';

// void main() {
//   runApp(const MyApp());
// }


void main() {
  WidgetsFlutterBinding.ensureInitialized();
  Get.put(UserController()); // UserController 초기화
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

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
                            bool isLogin = await Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => WebLogin()),
                            );
                            if (isLogin ?? false) {
                              Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => WebLoginScreen(title: '')),
                              );
                            }
                          },
                          child: Text(
                            "로그인",
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => WebJoin()),
                            );
                          },
                          child: Text(
                            "회원가입",
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
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => WebNotice()),
                            );
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
                      itemBuilder: (BuildContext context, int itemIndex, int pageViewIndex) =>
                          Container(
                            child: Image.network(imgList[itemIndex], fit: BoxFit.cover),
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
                              style: TextStyle(fontSize: 80, fontWeight: FontWeight.bold, color: Colors.white),
                            ),
                          ),
                          Container(
                            child: Text(
                              "일상의 행복한 변화",
                              style: TextStyle(fontSize: 40, color: Colors.white),
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
              // 나머지 스택 위젯들도 동일한 방식으로 수정
            ],
          ),
        ),
      ),
    );
  }
}
