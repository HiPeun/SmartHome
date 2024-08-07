import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'firebase_options.dart' ;

import 'package:kakao_flutter_sdk_user/kakao_flutter_sdk_user.dart';
import 'package:loginproject/App/app_screen/bottom_bar.dart';
import 'Web/webmain.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );


  // runApp() 호출 전 Flutter SDK 초기화
  KakaoSdk.init(
    nativeAppKey: 'd664273b8aeac06793c0c6f6f1ed0348',
    javaScriptAppKey: '38e21ce41bf7993c5366257c746421e3',
  );

  runApp(MyApp());
}

Map<String, dynamic> user = {};

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: kIsWeb ? MyHomePage() : BottomBar(),
      debugShowCheckedModeBanner: false,
    );
  }
}
