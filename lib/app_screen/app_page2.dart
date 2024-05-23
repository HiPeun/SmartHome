import 'package:flutter/material.dart';

import 'app_main.dart';

class Page2 extends StatefulWidget {
  const Page2({super.key});

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
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
                padding: const EdgeInsets.only(right: 3),
                child: InkWell(
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
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(10, 0, 15, 0),
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
    );
  }
}
