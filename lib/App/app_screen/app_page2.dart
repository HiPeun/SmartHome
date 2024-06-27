import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:loginproject/App/Arduino/cctv.dart';
import 'package:loginproject/main.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'app_join.dart';
import 'app_login.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

//메인 페이지
class Page2 extends StatefulWidget {
  const Page2({
    Key? key,
  }) : super(key: key);

  @override
  State<Page2> createState() => _Page2State();
}

class _Page2State extends State<Page2> {
  bool selected = false;
  bool isLedOn = false; // led true false
  String temperatureData = '';
  String humidityData = '';
  Dio dio = Dio(
    BaseOptions(
      connectTimeout: Duration(seconds: 10),
      receiveTimeout: Duration(seconds: 200),
      sendTimeout: Duration(seconds: 10),
    ),
  );
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();
  late WebSocketChannel channel; // 웹소켓
  bool WebSocketbutton = false; // 웹소켓 버튼

  String fireStatus = 'No fire detected';

  bool is90Degrees = false;
  bool is90Degrees2 = false;

  @override
  void initState() {
    super.initState();
    _initializeNotifications();
    _connectWebSocket();
  }

  @override
  void dispose() {
    super.dispose();
    channel.sink.close();
  }

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

  // led on off 메서드!
  void sendCommand(String command) async {
    String url = 'http://192.168.0.226/?cmd=$command';
    try {
      final response = await Dio().get(url);
      if (response.statusCode == 200) {
        print('Command sent: $command');
        setState(() {
          isLedOn = command == '1';
        });

        // 스낵바 표시
        final snackBar = SnackBar(
          content: Text(isLedOn ? '불이 켜졌습니다.' : '불이 꺼졌습니다.'),
          duration: Duration(seconds: 2),
        );
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } else {
        print('Failed to send command. Error code: ${response.statusCode}');
      }
    } on DioError catch (e) {
      print('Error sending command: ${e.response?.statusCode} - ${e.message}');
    }
  }

  // 온습도 받아오는 메서드
  Future<void> fetchData() async {
    String urlTemp = 'http://192.168.0.197/temp'; // 온도 정보 요청 URL
    String urlHumi = 'http://192.168.0.197/humi'; // 습도 정보 요청 URL

    try {
      Dio dio = Dio(); // Dio 객체 생성
      // 온도 데이터 요청
      Response responseTemp = await dio.get(urlTemp);
      if (responseTemp.statusCode == 200) {
        temperatureData = responseTemp.data.toString(); // 온도 데이터 저장
      } else {
        throw Exception(
            'Failed to fetch temperature data. Error code: ${responseTemp.statusCode}');
      }

      // 습도 데이터 요청
      Response responseHumi = await dio.get(urlHumi);
      if (responseHumi.statusCode == 200) {
        humidityData = responseHumi.data.toString(); // 습도 데이터 저장
      } else {
        throw Exception(
            'Failed to fetch humidity data. Error code: ${responseHumi.statusCode}');
      }

      // 데이터를 성공적으로 받아왔을 때 스낵바로 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('현재 온도: $temperatureData \n현재 습도: $humidityData'),
        ),
      );
    } catch (e) {
      print('Error fetching data: $e');
      // 에러 발생 시 스낵바로 에러 메시지 표시
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('서버오류 다시 시도해주세요'),
        ),
      );
    }
  }

  // 현관문 개폐 메서드
  Future<void> setAngle(int angle) async {
    String url = 'http://192.168.0.198/setAngle1?angle=$angle';
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        // 스낵바로 상태 알림
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(is90Degrees ? '현관문이 열렸습니다  ' : '현관문이 닫혔습니다..'),
            duration: Duration(seconds: 2),
          ),
        );

        print('Angle1 set successfully $angle degrees successfully');
      } else {
        print('Failed to set Sorvo 1 angle. Error: ${res.statusCode}');
      }
    } catch (e) {
      print('Failed to set Sorvo 1 angle. Exception: $e');
    }
  }

  // 창문 개폐 메서드
  Future<void> setAngle2(int angle) async {
    String url = 'http://192.168.0.198/setAngle2?angle=$angle';
    try {
      final res = await http.get(Uri.parse(url));
      if (res.statusCode == 200) {
        // 스낵바로 상태 알림
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(is90Degrees2 ? '창문이 열렸습니다.' : '창문이 닫혔습니다.'),
            duration: Duration(seconds: 2),
          ),
        );
        print('Servo 2 Angle set to $angle degrees successfully');
      } else {
        print('Failed to set Servo 2 angle. Error: ${res.statusCode}');
      }
    } catch (e) {
      print('Failed to set Servo 2 angle. Exception: $e');
    }
  }

  // 웹소켓
  void _initializeNotifications() {
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings();

    final InitializationSettings initializationSettings =
    InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS,
    );

    flutterLocalNotificationsPlugin.initialize(initializationSettings);
  }

  // 웹소켓 불꽃감지센서
  void _connectWebSocket() {
    channel = IOWebSocketChannel.connect('ws://192.168.0.189:8765');
    channel.stream.listen((message) {
      print('Received: $message');
      if (message == 'Danger' && user.isNotEmpty == true) {
        WebSocketbutton = true; // 상태 업데이트
        sendEmergencyNotification();
        showDangerAlert();
      } else {
        WebSocketbutton = false; // 상태 업데이트
      }
    });
  }

  // 웹 소켓 버튼
  void _WebSocketbutton() {
    if (WebSocketbutton == false) {
      showSafeAlert();
    } else {
      showDangerAlert();
    }
  }

  // 불꽃 감지 센서 상태 확인 메서드
  Future<void> sendEmergencyNotification() async {
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
    AndroidNotificationDetails(
      'emergency_channel_id',
      '비상 알림',
      channelDescription: '비상 상황을 위한 알림',
      importance: Importance.max,
      priority: Priority.high,
      enableLights: true,
      enableVibration: true,
      playSound: true,
      sound: RawResourceAndroidNotificationSound('emergency_sound'),
      fullScreenIntent: true,
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
    );

    await flutterLocalNotificationsPlugin.show(
      0,
      '비상!',
      '불이 감지되었습니다. 긴급 상황입니다. 비상 서비스에 연락하세요.',
      platformChannelSpecifics,
      payload: 'emergency',
    );
  }

  void showDangerAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('위험 감지!'),
          content: Text('불이 감지되었습니다. 필요한 조치를 취하세요!'),
          actions: <Widget>[
            TextButton(
              child: Text('닫기'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => CcTv()));
              },
            ),
          ],
        );
      },
    );
  }

  void showSafeAlert() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('안전 상태'),
          content: Text('불이 감지되지 않았습니다. 현재 상황은 안전합니다.'),
          actions: <Widget>[
            TextButton(
              child: Text('닫기'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  // 로그인 후
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
  Widget build(BuildContext context) {
    return Material(
      child: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  Stack(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selected = !selected;
                                });
                              },
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Container(
                                  height: 30,
                                  child: AnimatedDefaultTextStyle(
                                    child: Text("Conven"),
                                    style: TextStyle(
                                      fontSize: 30.0,
                                      color: selected ? Colors.blueAccent : Colors.black,
                                      fontWeight:
                                      selected ? FontWeight.w300 : FontWeight.bold,
                                    ),
                                    duration: const Duration(milliseconds: 400),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          if (user.isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(right: 40, top: 12),
                              child: Row(
                                children: [
                                  Text(
                                    "반가워요, ${user["name"]}님!",
                                    style: TextStyle(
                                      fontSize: 20,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          InkWell(
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
                            child: Row(
                              children: [
                                Column(
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
                              ],
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
                    ],
                  ),
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
              SingleChildScrollView(
                child: Row(
                  children: [
                    SmartControl(
                      text: "조명제어",
                      image: "assets/images/lightimage.png",
                      isOn: isLedOn,
                      switchControl: Switch(
                        value: isLedOn,
                        onChanged: (value) {
                          if (user.isNotEmpty) {
                            sendCommand(value ? '1' : '0');
                          } else {
                            showLoginAlert(context);
                          }
                        },
                      ),
                    ),
                    SmartControl(
                      text: "CCTV",
                      image: "assets/images/cctvimage.png",
                      iconButton: IconButton(
                        onPressed: () {
                          if (user.isNotEmpty) {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CcTv(),
                              ),
                            );
                          } else {
                            showLoginAlert(context);
                          }
                        },
                        icon: Icon(Icons.power_settings_new_outlined),
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  SmartControl(
                    text: "현관문개폐",
                    image: "assets/images/doorimage.png",
                    isOn: is90Degrees,
                    switchControl: Switch(
                      value: is90Degrees,
                      onChanged: (value) {
                        if (user.isNotEmpty) {
                          setAngle(value ? 0 : 180);
                          setState(() {
                            is90Degrees = value;
                          });
                        } else {
                          showLoginAlert(context);
                        }
                      },
                    ),
                  ),
                  SmartControl(
                    text: "창문개폐",
                    image: "assets/images/windowimage.png",
                    isOn: is90Degrees2,
                    switchControl: Switch(
                      value: is90Degrees2,
                      onChanged: (value) {
                        if (user.isNotEmpty) {
                          setAngle2(value ? 0 : 180);
                          setState(() {
                            is90Degrees2 = value;
                          });
                        } else {
                          showLoginAlert(context);
                        }
                      },
                    ),
                  ),
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
                          fetchData();
                        } else {
                          showLoginAlert(context);
                        }
                      },
                      icon: Icon(Icons.power_settings_new_outlined),
                    ),
                  ),
                  SmartControl(
                    text: "화재감지",
                    image: "assets/images/fireimage.png",
                    iconButton: IconButton(
                      onPressed: () {
                        if (user.isNotEmpty) {
                          _WebSocketbutton();
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

// 스마트 컨트롤러
class SmartControl extends StatelessWidget {
  final String text;
  final String image;
  final bool? isOn;
  final Switch? switchControl;
  final IconButton? iconButton;

  const SmartControl({
    required this.text,
    required this.image,
    this.isOn,
    this.switchControl,
    this.iconButton,
    super.key,
  });

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
              color: isOn == null || isOn == false
                  ? const Color(0xFFE5E5E1)
                  : const Color(0xFFFFEEEE),
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
                if (switchControl != null) switchControl!,
                if (iconButton != null) iconButton!,
              ],
            ),
          ),
        ],
      ),
    );
  }
}

//메인 뷰
class AppMainView extends StatefulWidget {
  const AppMainView({super.key});

  @override
  State<AppMainView> createState() => _AppMainViewState();
}

class _AppMainViewState extends State<AppMainView> {
  bool selected = false;
  // 이미지 슬라이더 list로 묶음
  final List<String> imgList = [
    'assets/webmain/webmain1.png',
    'assets/webmain/webmain2.png',
    'assets/webmain/webmain3.png',
    'assets/webmain/webmain4.png',
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const Padding(padding: EdgeInsets.fromLTRB(0, 10, 0, 0)),
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
            autoPlayInterval: const Duration(seconds: 5),
          ),
        ),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 60),
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selected = !selected;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      height: 40,
                      child: AnimatedDefaultTextStyle(
                        child: Text("Smart Home"),
                        style: TextStyle(
                          fontSize: 40.0,
                          color: selected ? Colors.black : Colors.white,
                          fontWeight:
                          selected ? FontWeight.bold : FontWeight.bold,
                        ),
                        duration: const Duration(milliseconds: 300),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 0),
                child: const Text(
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
    );
  }
}
