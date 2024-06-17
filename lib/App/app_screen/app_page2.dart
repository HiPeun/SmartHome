import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginproject/App/main.dart';
import 'app_join.dart';
import 'app_login.dart';
import 'package:dio/dio.dart';

class Page2 extends StatefulWidget {
  const Page2({
    Key? key,
  }) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  bool isLedOn = false;
  Dio dio = Dio();

  // 로그아웃 메서드 생성 부분
  void _logout() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('로그아웃'),
          content: Text('정말 로그아웃하시겠습니까?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: Text('취소'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
                user = {};
                setState(() {});
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  void sendCommand(String command) async {
    String url = 'http://192.168.0.221/?cmd=$command'; // ESP8266의 IP 주소와 포트를 입력하세요

    try {
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        print('Command sent: $command');
        setState(() {
          if (command == '1') {
            isLedOn = true;
          } else {
            isLedOn = false;
          }
        });
      } else {
        print('Failed to send command. Error code: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print('Error sending command: ${e.response?.statusCode} - ${e.message}');
    }
  }

  void showLoginAlert(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('알림'),
          content: Text('로그인 후 이용해 주세요'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // 다이얼로그 닫기
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(left: 10, bottom: 10),
                      child: Text(
                        "Conven",
                        style: TextStyle(
                          fontSize: 32.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 3),
                    child: InkWell(
                      onTap: () async {
                        if (user.isNotEmpty) {
                          _logout(); // 로그아웃 확인 다이얼로그 표시
                        } else {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AppLogin(),
                            ),
                          );

                          setState(() {});
                        }
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            "assets/images/backbutton.png",
                            width: 26,
                            height: 26,
                            fit: BoxFit.cover,
                          ),
                          Text(user.isEmpty ? "로그인 " : "로그아웃"),
                        ],
                      ),
                    ),
                  ),
                  if (user.isEmpty)
                    Padding(
                      padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) => AppJoin()));
                        },
                        child: Column(
                          children: [
                            Image.asset(
                              user.isEmpty
                                  ? "assets/images/person2.png"
                                  : "assets/images/personbutton.png",
                              width: 26,
                              height: 26,
                              fit: BoxFit.cover,
                            ),
                            Text(user.isEmpty ? "회원가입" : "내 정보"),
                          ],
                        ),
                      ),
                    ),
                ],
              ),
              if (user.isNotEmpty)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("반가워요, ${user["id"]}님!",
                        style: TextStyle(fontSize: 20)),
                  ],
                ),

              AppMainView(),
              Row(
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
              ),
              Row(
                children: [
                  SmartControl(
                      text: "조명제어",
                      image: "assets/images/lightimage.png",
                      iconButton: IconButton(
                        onPressed: () {
                          if (user.isNotEmpty) {
                          sendCommand('1');
                        } else {
                            showLoginAlert(context);
                          }
                        },
                        icon: Icon(Icons.power_settings_new_outlined),
                      )),
                  SmartControl(
                      text: "CCTV",
                      image: "assets/images/cctvimage.png",
                      iconButton: IconButton(
                        onPressed: () {
                          if (user.isNotEmpty) {
                        } else {
                            showLoginAlert(context);
                          }
                        },
                        icon: Icon(Icons.power_settings_new_outlined),
                      )),
                ],
              ),
              Row(
                children: [
                  SmartControl(
                      text: "현관문개폐",
                      image: "assets/images/doorimage.png",
                      iconButton: IconButton(
                        onPressed: () {
                          if (user.isNotEmpty) {
                        } else {
                            showLoginAlert(context);
                          }
                        },
                        icon: Icon(Icons.power_settings_new_outlined),
                      )),
                  SmartControl(
                      text: "창문개폐",
                      image: "assets/images/windowimage.png",
                      iconButton: IconButton(
                        onPressed: () {
                          if (user.isNotEmpty) {
                        } else {
                            showLoginAlert(context);
                          }
                        },
                        icon: Icon(Icons.power_settings_new_outlined),
                      )),
                ],
              ),
              Row(
                children: [
                  SmartControl(
                      text: "온습도측정",
                      image: "assets/images/homeimage.png",
                      iconButton: IconButton(
                        onPressed: () {
                          if (user.isNotEmpty) {
                          } else {
                            showLoginAlert(context);
                          }
                        },
                        icon: Icon(Icons.power_settings_new_outlined),
                      )),
                  SmartControl(
                    text: "화재감지",
                    image: "assets/images/fireimage.png",
                    iconButton: IconButton(
                      onPressed: () {
                        if (user.isNotEmpty) {
                        } else {
                          showLoginAlert(context);
                        }
                      },
                      icon: Icon(Icons.power_settings_new_outlined),
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

// 바텀바 부분

class SmartControl extends StatelessWidget {
  final String text;
  final String image;
  final IconButton iconButton;

  const SmartControl(
      {required this.iconButton,
        required this.image,
        required this.text,
        super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          Container(
            margin: const EdgeInsets.all(15),
            padding: const EdgeInsets.all(15),
            width: MediaQuery.of(context).size.width * 0.42,
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
                      image,
                      fit: BoxFit.fill,
                    ),
                    Text(
                      text,
                    ),
                  ],
                ),
                iconButton,
              ],
            ),
          ),
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

