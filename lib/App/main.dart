import 'package:flutter/material.dart';
import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:loginproject/App/app_screen/bottom_bar.dart';
import 'app_screen/app_login.dart';
import 'app_screen/app_page1.dart';
import 'app_screen/app_page2.dart';
import 'app_screen/app_page3.dart';

void main() {
  // 웹 환경에서 카카오 로그인을 정상적으로 완료하려면 runApp() 호출 전 아래 메서드 호출 필요
  WidgetsFlutterBinding.ensureInitialized();

  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: 'd664273b8aeac06793c0c6f6f1ed0348',
    javaScriptAppKey: '38e21ce41bf7993c5366257c746421e3',
  );

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BottomBar(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => AppLogin(),
        '/page1': (context) => Page1(),
        '/page2': (context) => Page2(),
        '/page3': (context) => Page3(),
      },
    );
  }
}
