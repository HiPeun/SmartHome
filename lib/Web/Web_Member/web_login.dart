import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:loginproject/Web/Web_Cus/web_notice.dart';
import 'package:loginproject/Web/Web_Member/web_fid.dart';
import 'package:loginproject/Web/Web_Member/web_fpw.dart';
import 'package:loginproject/Web/Web_Member/web_join.dart';
import 'package:loginproject/Web/Web_Member/web_login_screen.dart';
import 'package:loginproject/Web/Web_Member/web_modify_profile.dart';

import '../webmain.dart';


void main() async {
// 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: 'd664273b8aeac06793c0c6f6f1ed0348',
    javaScriptAppKey: '38e21ce41bf7993c5366257c746421e3',
  );
  runApp(const MyApp());
}


// 로그인 완료시 main페이지로 이동
void navigateToMainPage(BuildContext context) {
  Navigator.of(context as BuildContext).pushReplacement(MaterialPageRoute(
      builder: (context) => MyApp()
  ));
}

// 카카오 로그인 구현 예제
Future<void> KakaoLogin(BuildContext context) async {
// 카카오톡 실행 가능 여부 확인
// 카카오톡 실행이 가능하면 카카오톡으로 로그인, 아니면 카카오계정으로 로그인
  if (await isKakaoTalkInstalled()) {
    try {
      await UserApi.instance.loginWithKakaoTalk().then((value) {
        print('value from kakao $value');
        navigateToMainPage(context);
      });
      print('카카오톡으로 로그인 성공');
      Navigator.pushReplacementNamed(context as BuildContext, '/webmain'); // 로그인 성공 시 메인 페이지로 이동
    } catch (error) {
      print(await KakaoSdk.origin);
      print('카카오톡으로 로그인 실패 $error');

      // 사용자가 카카오톡 설치 후 디바이스 권한 요청 화면에서 로그인을 취소한 경우,
      // 의도적인 로그인 취소로 보고 카카오계정으로 로그인 시도 없이 로그인 취소로 처리 (예: 뒤로 가기)
      if (error is PlatformException && error.code == 'CANCELED') {
        return;
      }
      // 카카오톡에 연결된 카카오계정이 없는 경우, 카카오계정으로 로그인
      try {
        await UserApi.instance.loginWithKakaoAccount().then((value) {
          navigateToMainPage(context);
        });
        print('카카오계정으로 로그인 성공');
        Navigator.pushReplacementNamed(context as BuildContext, '/webmain'); // 로그인 성공 시 메인 페이지로 이동
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
      Navigator.pushReplacementNamed(context as BuildContext, '/webmain'); // 로그인 성공 시 메인 페이지로 이동
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


//받아라지윤
class WebLogin extends StatefulWidget {
  WebLogin({super.key});

  @override
  State<StatefulWidget> createState() => _WebLoginState();
}

class _WebLoginState extends State<WebLogin> {
  final TextEditingController _id = TextEditingController();
  final TextEditingController _pw = TextEditingController();

  void login() async {
    try {
      final Map<String, dynamic> data = {
        "id" : _id.text,
        "pw" : _pw.text,
      };
      final Dio dio = Dio(BaseOptions(baseUrl: "http://192.168.0.177:9090"));
        Response res = await dio.post("/user/login", data: data);
          if (res.statusCode == 200) {
            Navigator.push(context, MaterialPageRoute(builder: (context)=> WebLoginScreen(title: ""),
            ));
          }
    } catch (e) {
      print(e);
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        top: true,
        child: Column(
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
              child: Padding(
                padding: const EdgeInsets.only(top: 30, left: 50, bottom: 20),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Conven",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 50,
                            ),
                          ),
                          Text(
                            "계정을 로그인 합니다",
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.black54,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => WebLogin(),
                          ));
                        },
                        child: Text(
                          "로그인",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => WebJoin(),
                          ));
                        },
                        child: Text(
                          "회원가입",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 40),
                      child: InkWell(
                        onTap: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) => WebNotice(),
                          ));
                        },
                        child: Text(
                          "고객센터",
                          style: TextStyle(
                            fontSize: 22,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 90),
              child: InkWell(
                onTap: () async {
                  print(await KakaoSdk.origin);
                  KakaoLogin(context);
                },
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Color(0xffF9E000),
                  ),
                  width: 400,
                  height: 55,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        child: Image.asset(
                          "assets/images/kakao.png",
                          width: 30,
                          height: 30,
                        ),
                      ),
                      Container(
                        child: Text(
                          "카카오톡으로 시작하기",
                          style: TextStyle(
                            fontSize: 19,
                          ),
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
            SizedBox(height: 20),
            Container(
              margin: EdgeInsets.only(top: 15),
              width: 400,
              child: TextField(
                maxLength: 12,
                decoration: InputDecoration(labelText: 'ID'),
                keyboardType: TextInputType.emailAddress,
                controller: _id,
                obscureText: false,
              ),
            ),
            Container(
              width: 400,
              child: TextField(
                maxLength: 12,
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
              width: 400,
              height: 55,
              child: InkWell(
                child: Center(
                  child: Text(
                    "로 그 인",
                    style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                ),
                onTap: () {
                  login();
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: EdgeInsets.only(right: 120, top: 10),
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => WebJoin(),
                      ));
                    },
                    child: Text(
                      "회원가입",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: InkWell(
                    child: Text(
                      "아이디 찾기",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => WebFid(),
                      ));
                    },
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: InkWell(
                    child: Text(
                      " 비밀번호 찾기",
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => WebFpw(),
                      ));
                    },
                  ),
                ),

              ],
            )
          ],
        ),
      ),
    );
  }
}
