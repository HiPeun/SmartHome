import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_fpw.dart';
import 'app_join.dart';
import 'bottom_bar.dart'; // BottomBar를 import합니다.

class AppLogin extends StatefulWidget {
  @override
  _AppLoginState createState() => _AppLoginState();
}

class _AppLoginState extends State<AppLogin> {
  final TextEditingController _id = TextEditingController();
  final TextEditingController _pw = TextEditingController();
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _loadUserId();
    _clearStoredToken(); // 앱 실행 시 토큰 삭제
  }

  Future<void> _loadUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? savedId = prefs.getString('user_id');
    if (savedId != null) {
      setState(() {
        _id.text = savedId;
      });
    }
  }

  Future<void> _clearStoredToken() async {
    await secureStorage.delete(key: 'auth_token');
  }

  void login() async {
    if (_id.text.isEmpty || _pw.text.isEmpty) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('입력 오류'),
            content: Text('아이디와 비밀번호를 입력해주세요'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('확인'),
              ),
            ],
          );
        },
      );
      return;
    }

    try {
      final Map<String, dynamic> data = {
        "id": _id.text,
        "pw": _pw.text,
      };
      final Dio dio = Dio(BaseOptions(baseUrl: "http://192.168.0.177:9090"));
      Response res = await dio.post("/user/login", data: data);

      if (res.statusCode == 200 && res.data is bool && res.data == true) {
        // 로그인 성공 시 토큰 저장 및 메인 페이지로 이동
        await secureStorage.write(key: 'auth_token', value: 'your_token');
        await _saveUserId(_id.text);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => BottomBar(isLogin: true)),
        );
      } else if (res.statusCode == 200 && res.data is Map<String, dynamic>) {
        final userData = res.data['userData'] as String; // 사용자 데이터를 받아옴
        await secureStorage.write(key: 'auth_token', value: 'your_token');
        await _saveUserId(_id.text);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => BottomBar(
              isLogin: true,
              userData: userData,
            ),
          ),
        );
      } else {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('로그인 실패'),
              content: Text('아이디와 비밀번호가 맞지 않습니다'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('확인'),
                ),
              ],
            );
          },
        );
      }
    } on DioException catch (e) {
      print("Error: $e");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('서버 오류'),
            content: Text('서버에서 오류가 발생했습니다. 잠시 후 다시 시도해주세요.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('확인'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print("Error: $e");
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('로그인 오류'),
            content: Text('로그인 중 오류가 발생했습니다: $e'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('확인'),
              ),
            ],
          );
        },
      );
    }
  }

  Future<void> _saveUserId(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_id', userId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
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
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {
                      kakaoLogin(context);
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
                          ),
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
                width: 300,
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    width: 35,
                    height: 50,
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      "아이디 찾기",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
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
      ),
    );
  }
}

// 카카오 로그인 관련 함수들
Future<void> kakaoLogin(BuildContext context) async {
  if (await isKakaoTalkInstalled()) {
    try {
      await UserApi.instance.loginWithKakaoTalk();
      print('카카오톡으로 로그인 성공');
      navigateToMainPage(context, "kakaoUser");
    } catch (error) {
      print('카카오톡으로 로그인 실패 ');
      if (error is PlatformException && error.code == 'CANCELED') {
        return;
      }
      await _loginWithKakaoAccount(context);
    }
  } else {
    await _loginWithKakaoAccount(context);
  }
}

Future<void> _loginWithKakaoAccount(BuildContext context) async {
  try {
    await UserApi.instance.loginWithKakaoAccount();
    print('카카오계정으로 로그인 성공');
    navigateToMainPage(context, "kakaoUser");
  } catch (error) {
    print('카카오계정으로 로그인 실패 ');
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('로그인 실패'),
          content: Text('카카오계정으로 로그인 실패: $error'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('확인'),
            ),
          ],
        );
      },
    );
  }
}

void navigateToMainPage(BuildContext context, String userData) {
  Navigator.of(context).pushReplacement(
    MaterialPageRoute(
        builder: (context) => BottomBar(isLogin: true, userData: userData)),
  );
}

Future<void> kakaoLogout() async {
  try {
    await UserApi.instance.logout();
    print('로그아웃 성공, SDK에서 토큰 삭제');
  } catch (error) {
    print('로그아웃 실패, SDK에서 토큰 삭제 $error');
  }
}
