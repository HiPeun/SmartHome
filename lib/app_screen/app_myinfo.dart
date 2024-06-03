import 'package:flutter/material.dart';
import 'package:loginproject/app_screen/app_join.dart';

import 'app_main.dart';

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