import "package:carousel_slider/carousel_slider.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";
import "package:flutter/widgets.dart";
import "package:loginproject/app_screen/app_page1.dart";
import "package:loginproject/app_screen/app_page2.dart";
import "package:loginproject/app_screen/app_page3.dart";





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
                fontSize: 30, fontWeight: FontWeight.bold, color: Colors.black),
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

  const SmartControl(
      {required this.iconButton,
      required this.image,
      required this.text,
      super.key});

  @override
  State<SmartControl> createState() => _SmartControlState();
}

class _SmartControlState extends State<SmartControl> {
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
        ],
      ),
    );
  }
}

class BottomBar extends StatefulWidget {
  const BottomBar({super.key});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 0;

  final List<Widget> _widgetOptions = <Widget>[
    Page1(),
    Page2(),
    Page3()
  ];

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

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
