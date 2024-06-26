import 'package:flutter/material.dart';
import 'package:loginproject/App/app_cus/app_notice.dart';
import 'package:loginproject/App/app_cus/app_notice_screen.dart';
import 'package:loginproject/App/app_screen/app_login.dart';
import '../../main.dart';
import 'app_page2.dart';
import 'app_page3.dart';

class BottomBar extends StatefulWidget {
  final bool isLogin;
  final String userData;

  const BottomBar({Key? key, this.isLogin = false, this.userData = ''})
      : super(key: key);

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  int _selectedIndex = 1; // 기본값을 1로 설정하여 Page2를 기본 페이지로 설정합니다.

  late final List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _widgetOptions = <Widget>[
      AppNotice(),
      Page2(),
      AppModifyProfile(),
    ];
  }


  void _onItemTapped(int index) async {
    if (index == 2) {
      if (user.isEmpty) {
        await Navigator.of(context).push(
          MaterialPageRoute(
            builder: (BuildContext context) => AppLogin(),
          ),
        );
        return;
      }
    }
    setState(() {
      _selectedIndex = index;
    });
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
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        toolbarHeight: 0,
      ),
      body: SafeArea(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.black,
        onTap: _onItemTapped,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt),
            label: "Q&A",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "홈",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: "내 정보",
          ),
        ],
      ),
    );
  }
}
