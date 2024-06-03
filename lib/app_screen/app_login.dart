import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:loginproject/app_screen/app_fpw.dart';
import 'package:loginproject/app_screen/app_join.dart';
import 'package:loginproject/app_screen/app_myinfo.dart';

// 로그인 완료시 main페이지로 이동
void navigateToMainPage(BuildContext context) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(builder: (context) => InfoPage()),
  );
}

// 카카오 로그인 구현 예제
Future<void> KakaoLogin(BuildContext context) async {
  // 카카오톡 실행 가능 여부 확인
  if (await isKakaoTalkInstalled()) {
    try {
      await UserApi.instance.loginWithKakaoTalk().then((value) {
        print('value from kakao $value');
        navigateToMainPage(context);
      });
      print('카카오톡으로 로그인 성공');
    } catch (error) {
      print(await KakaoSdk.origin);
      print('카카오톡으로 로그인 실패 $error');
      if (error is PlatformException && error.code == 'CANCELED') {
        return;
      }
      try {
        await UserApi.instance.loginWithKakaoAccount().then((value) {
          navigateToMainPage(context);
        });
        print('카카오계정으로 로그인 성공');
      } catch (error) {
        print('카카오계정으로 로그인 실패 $error');
      }
    }
  } else {
    try {
      await UserApi.instance.loginWithKakaoAccount().then((value) {
        print('value from kakao $value');
        navigateToMainPage(context);
      });
      print('카카오계정으로 로그인 성공');
    } catch (error) {
      print('카카오계정으로 로그인 실패 $error');
    }
  }
}

// 카카오 로그 아웃
Future<void> KakaoLogout() async {
  try {
    await UserApi.instance.logout();
    print('로그아웃 성공, SDK에서 토큰 삭제');
  } catch (error) {
    print('로그아웃 실패, SDK에서 토큰 삭제 $error');
  }
}

class AppLogin extends StatefulWidget {
  AppLogin({super.key});

  @override
  State<StatefulWidget> createState() => _AppLoginState();
}

class _AppLoginState extends State<AppLogin> {
  final TextEditingController _id = TextEditingController();
  final TextEditingController _pw = TextEditingController();
  bool isLogin = false;

  void login() async {
    try {
      final Map<String, dynamic> data = {
        "id": _id.text,
        "pw": _pw.text
      };
      final Dio dio = Dio(BaseOptions(baseUrl: "http://192.168.0.177:9090"));
      Response res = await dio.post("/user/login", data: data);
      if (res.statusCode == 200) {
        Navigator.pop(context, true);
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 170,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Color(0xFFD3CDC8),
                    borderRadius: BorderRadius.vertical(
                      bottom: Radius.circular(30),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20),
                  child: Text(
                    "로그인",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(top: 90),
              child: Material(
                color: Colors.transparent, // 필요한 경우 배경 색상 지정
                child: InkWell(
                  onTap: () {
                    KakaoLogin(context);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Color(0xffF9E000),
                    ),
                    width: 300,
                    height: 55,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Image.asset(
                          "assets/images/kakao.png",
                          width: 30,
                          height: 30,
                        ),
                        Text(
                          "카카오톡으로 시작하기",
                          style: TextStyle(
                            fontSize: 19,
                          ),
                        ),
                        SizedBox(
                          width: 10,
                          height: 10,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  labelText: 'ID',
                ),
                keyboardType: TextInputType.emailAddress,
                controller: _id,
                obscureText: false,
              ),
            ),
            Container(
              width: 300,
              child: TextField(
                maxLength: 10,
                decoration: InputDecoration(
                  labelText: 'Password',
                ),
                keyboardType: TextInputType.emailAddress,
                controller: _pw,
                obscureText: true,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Color(0xFFD3CDC8),
              ),
              margin: EdgeInsets.only(top: 20),
              width: 300,
              height: 55,

                child: InkWell(
                    onTap: () {
                      login();
                    },
                  child: Center(
                    child: Text(
                      "로 그 인",
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
              ),

            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                SizedBox(
                  width: 35,
                  height: 50,
                ),
                Container(
                  child: TextButton(
                    onPressed: () {},
                    child: Text(
                      "아이디 찾기",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AppFpw(),
                    ));
                  },
                  child: Text(
                    "비밀번호 찾기",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
                SizedBox(
                  width: 60,
                  height: 10,
                ),
                TextButton(
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => AppJoin(),
                    ));
                  },
                  child: Text(
                    "회원가입",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}



