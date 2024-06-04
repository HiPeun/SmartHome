import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:loginproject/app_screen/app_join.dart';



class InfoPage extends StatefulWidget {
  const InfoPage({super.key});

  @override
  State<InfoPage> createState() => _InfoPageState();
}
class _InfoPageState extends State<InfoPage> {
  bool isLogin = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
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
                padding: const EdgeInsets.fromLTRB(10, 0, 15, 0),
                child: InkWell(
                  onTap: () {
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => AppJoin()));

                  },
                  child: Column(
                    children: [
                      Image.asset(
                        "assets/images/person2.png",
                        width: 26,
                        height: 26,
                        fit: BoxFit.cover,
                      ),
                      Text("내 정보"),
                    ],
                  ),
                ),
              ),
            ],
          ),
          AppMainView2(),
          SmartText2(),
          Row(
            children: [
              SmartControl2(
                  text: "조명제어",
                  image: "assets/images/lightimage.png",
                  iconButton: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.power_settings_new_outlined),
                  )),
              SmartControl2(
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
              SmartControl2(
                  text: "현관문개폐",
                  image: "assets/images/doorimage.png",
                  iconButton: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.power_settings_new_outlined),
                  )),
              SmartControl2(
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
              SmartControl2(
                  text: "온습도측정",
                  image: "assets/images/homeimage.png",
                  iconButton: IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.power_settings_new_outlined),
                  )),
              SmartControl2(
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
    );
  }
}


class SmartText2 extends StatefulWidget {
  const SmartText2({super.key});

  @override
  State<SmartText2> createState() => _SmartText2State();
}

class _SmartText2State extends State<SmartText2> {
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


class AppMainView2 extends StatefulWidget {
  const AppMainView2({super.key});

  @override
  State<AppMainView2> createState() => _AppMainView2State();
}

class _AppMainView2State extends State<AppMainView2> {
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

class SmartControl2 extends StatefulWidget {
  final String text;
  final String image;
  final IconButton iconButton;

  const SmartControl2(
      {required this.iconButton,
        required this.image,
        required this.text,
        super.key});

  @override
  State<SmartControl2> createState() => _SmartControl2State();
}

class _SmartControl2State extends State<SmartControl2> {
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