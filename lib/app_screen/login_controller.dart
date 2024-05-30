import 'package:get/get.dart';
import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:loginproject/app_screen/app_myinfo.dart';

import 'package:flutter/material.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var message = ''.obs;

  final TextEditingController id = TextEditingController();
  final TextEditingController pw = TextEditingController();

  Future<void> login(BuildContext context) async {
    isLoading(true);
    try {
      final Map<String, dynamic> data = {
        "id": id.text,
        "pw": pw.text,
      };
      final Dio dio = Dio(BaseOptions(baseUrl: "http://192.168.0.182:9090"));
      Response res = await dio.post("/user/login", data: data);

      if (res.statusCode == 200) {
        navigateToMainPage(context);
      } else {
        message('로그인 실패: ${res.statusCode} - ${res.statusMessage}');
      }
    } on DioError catch (e) {
      if (e.response != null) {
        message('Dio error: ${e.response?.statusCode} - ${e.response?.data}');
        print('Dio error: ${e.response?.statusCode} - ${e.response?.data}');
      } else {
        message('Dio error: ${e.message}');
        print('Dio error: ${e.message}');
      }
    } catch (e) {
      message('Unexpected error: $e');
      print('Unexpected error: $e');
    } finally {
      isLoading(false);
    }
  }

  void navigateToMainPage(BuildContext context) {
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (context) => InfoPage()),
    );
  }

  Future<void> kakaoLogin(BuildContext context) async {
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

  Future<void> kakaoLogout() async {
    try {
      await UserApi.instance.logout();
      print('로그아웃 성공, SDK에서 토큰 삭제');
    } catch (error) {
      print('로그아웃 실패, SDK에서 토큰 삭제 $error');
    }
  }
}
