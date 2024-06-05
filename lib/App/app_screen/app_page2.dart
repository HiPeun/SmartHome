import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'app_join.dart';
import 'app_login.dart';
import 'app_page1.dart';
import 'app_page3.dart';

class Page2 extends StatefulWidget {
  final bool isLogin;
  final String userData;

  const Page2({Key? key, this.isLogin = false, this.userData = ''}) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  //로그아웃 메서드 생성 부분
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
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Page2()),
                ); // 로그인 페이지로 이동
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
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
                      onTap: () {
                        if (widget.isLogin) {
                          _logout(); // 로그아웃 확인 다이얼로그 표시
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AppLogin(),
                            ),
                          );
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
                          Text(widget.isLogin ? "로그아웃" : "로그인"),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 0, 15, 0),
                    child: InkWell(
                      onTap: () {
                        Navigator.of(context).push(
                            MaterialPageRoute(builder: (context) => AppJoin()));
                      },
                      child: Column(
                        children: [
                          Image.asset(
                            widget.isLogin
                                ? "assets/images/personbutton.png"
                                : "assets/images/person2.png",
                            width: 26,
                            height: 26,
                            fit: BoxFit.cover,
                          ),
                          Text(widget.isLogin ? "내 정보" : "회원가입"),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              if (widget.isLogin)
                Text("환영합니다, ${widget.userData}님!", style: TextStyle(fontSize: 18)),
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
                        onPressed: () {},
                        icon: Icon(Icons.power_settings_new_outlined),
                      )),
                  SmartControl(
                      text: "CCTV",
                      image: "assets/images/cctvimage.png",
                      iconButton: IconButton(
                        onPressed: () {},
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
                        onPressed: () {},
                        icon: Icon(Icons.power_settings_new_outlined),
                      )),
                  SmartControl(
                      text: "창문개폐",
                      image: "assets/images/windowimage.png",
                      iconButton: IconButton(
                        onPressed: () {},
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
                        onPressed: () {},
                        icon: Icon(Icons.power_settings_new_outlined),
                      )),
                  SmartControl(
                    text: "화재감지",
                    image: "assets/images/fireimage.png",
                    iconButton: IconButton(
                      onPressed: () {},
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
class BottomBar extends StatefulWidget {
  final bool isLogin;
  final String userData;

  const BottomBar({Key? key, this.isLogin = false, this.userData = ''})
      : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  late final List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      Page1(),
      Page2(isLogin: widget.isLogin, userData: widget.userData),
      Page3(isLogin: widget.isLogin, userData: widget.userData,),
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: "Q&A",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "로그인",
          ),
        ],
      ),
    );
  }
}

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
