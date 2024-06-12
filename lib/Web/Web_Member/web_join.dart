import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:loginproject/Web/Web_Cus/web_notice.dart';
import 'package:loginproject/Web/Web_Member/web_login.dart';

class WebJoin extends StatefulWidget {
  WebJoin({super.key});

  @override
  State<StatefulWidget> createState() => _WebJoinState();
}

class _WebJoinState extends State<WebJoin> {
  TextEditingController email = TextEditingController();
  TextEditingController pw = TextEditingController();
  TextEditingController pw2 = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController id = TextEditingController();

  bool isAgreed = false;
  bool isPersonAgreed = false;
  bool isTermsAgreed = false;

  void toggleAgreement(bool value) {
    //이 값들이 변경되고 위젯이 빈화면이 되었다가 다시 그려짐 (체크가됨),이변수값을 주었으니 다시 그려줌
    setState(() {
      isAgreed = value;
      isPersonAgreed = value;
      isTermsAgreed = value;
    });
  }

  void initState(){
    //super.initState 코드는 현재 클래스에서 오버라이드 된
    // initState() 메서드 내에서 상위 클래스의 initState() 메서드를 호출
    super.initState();
    id = TextEditingController(text: "");
    pw = TextEditingController(text: "");
    pw2 = TextEditingController(text: "");
    email = TextEditingController(text: "");
    name = TextEditingController(text: "");
  }
//각 텍스트 필드의 입력값을 Controller를 사용하여 가져오고
// dispose을 사용해서 메모리 누수를 방지
  @override
  void dispose(){
    id.dispose();
    pw.dispose();
    pw2.dispose();
    email.dispose();
    name.dispose();
    //super.dispose를 호출하여 부모 클래스의 dispose 메소드를 실행하여 추가적인 정리 작업을 수행
    super.dispose();
  }
  void joins(String id, String pw, String name, String email) async {
    final dio = Dio(); //HTTP 클라이언트 라이브러리 Dio의 인스턴스 생성

    try {
      final response = await dio.post(
        "http://192.168.0.177:9090/user/join",
        data: {
          'id': id,
          'pw': pw,
          'name': name,
          'email': email,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              content: Text("회원가입이 완료되었습니다. \n로그인페이지로 이동합니다."),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => WebLogin(),
                    ));
                  },
                  child: Text('확인'),
                ),
              ],
            );
          },
        );


      } else {
        print("회원가입 실패: ${response.data}");
      }
    } catch (e) {
      print("회원가입 실패: $e");
    }
  }

  // 이메일 유효성 검사 함수
  bool isValidEmail(String email) {
    final RegExp emailRegex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return emailRegex.hasMatch(email);
  }

  void check(String id) async {
    final dio = Dio();

    try {
      final response = await dio.post(
        "http://192.168.0.188:9090/user/login/duplication",
        data: {
          'id': id,
        },
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );
      if (response.statusCode == 200) {
        bool isDuplicate = response.data as bool;
        if (isDuplicate) {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Text("이미 사용 중인 아이디입니다."),
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
      } else {
        print("아이디 중복 확인 실패: ${response.data}");
      }
    } catch (e) {
      showDialog(context: context,
          builder: (BuildContext context) {
         return AlertDialog(
           content: Text("사용 가능한 아이디입니다."),
           actions: [
             TextButton(onPressed: () {
               Navigator.of(context).pop();
             },
            child: Text("확인"),
             ),
           ],
         );
         },
      );
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
                            "계정을 생성합니다",
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
                          Navigator.of(context).push(MaterialPageRoute(builder: (context) => WebNotice(),
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
            SizedBox(
              height: 50,
            ),

            Center(
              child: Column(
                children: [
                  SizedBox(
                    width: 500,
                    child: TextField(
                      controller: name,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.person),
                        labelText: '이름',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        width: 410,
                        child: TextField(
                          controller: id,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.key),
                            labelText: '아이디',
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 10),
                      TextButton(
                        onPressed: () {
                          String joinId = id.text;
                          if (joinId.isEmpty) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text("아이디를 입력하세요."),
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

                          if (joinId.length > 12 || !joinId.contains(RegExp(r'\d'))) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text("아이디는 12자리 이하이고 숫자를 포함해야 합니다."),
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

                          check(joinId);
                        },
                        child: Text('중복확인', style: TextStyle(color: Colors.black)),
                        style: TextButton.styleFrom(
                          backgroundColor: Color(0xFFD3CDC8),
                          minimumSize: Size(60, 50),
                        ),
                      ),


                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 500,
                    child: TextField(
                      controller: pw,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: "비밀번호",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 500,
                    child: TextField(
                      controller: pw2,
                      obscureText: true,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.lock),
                        labelText: "비밀번호 확인",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: 500,
                    child: TextField(
                      controller: email,
                      decoration: InputDecoration(
                        prefixIcon: Icon(Icons.markunread_rounded),
                        labelText: "이메일",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 16),
                  Container(
                    width: 500,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: isAgreed,
                          onChanged: (value) {
                            toggleAgreement(value!);
                          },
                        ),
                        Text(
                          "전체 동의",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 500,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: isPersonAgreed,
                          onChanged: (value) {
                            setState(() {
                              isPersonAgreed = value!;
                              if (!value) {
                                isAgreed = false;
                              } else if (isTermsAgreed) {
                                isAgreed = true;
                              }
                            });
                          },
                        ),

                        Text(
                          "[필수] 개인 정보 수집",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    width: 500,
                    alignment: Alignment.centerLeft,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Checkbox(
                          value: isTermsAgreed,
                          onChanged: (value) {
                            setState(() {
                              isTermsAgreed = value!;
                              if (!value) {
                                isAgreed = false;
                              } else if (isPersonAgreed) {
                                isAgreed = true;
                              }
                            });
                          },
                        ),
                        Text(
                          "[필수] 이용약관",
                          style: TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Material(
                      elevation: 5.0,
                      borderRadius: BorderRadius.circular(30.0),
                      color: const Color(0xFFD3CDC8),
                      child: MaterialButton(
                        onPressed: () {
                          String joinName = name.text;
                          String joinId = id.text;
                          String joinPw = pw.text;
                          String joinPw2 = pw2.text;
                          String joinEmail = email.text;


                          if (joinName.length > 6) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text("이름은 6자리 이하로 입력하세요."),
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

                          if (joinId.length > 12 || !joinId.contains(RegExp(r'\d'))) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text("아이디는 12자리 이하이고 숫자를 포함해야 합니다."),
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


                          RegExp passwordRegex = RegExp(r'^(?=.*\d)(?=.*[a-zA-Z])(~?=.*[!@#$%^&*(),.?":{}|<>]).{5,12}$');
                          if (joinPw.length > 12 || !passwordRegex.hasMatch(joinPw)) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text("비밀번호는 5자에서 12자 사이이며, 문자와 숫자를 모두 포함해야 합니다."),
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

                          if (joinPw != joinPw2) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text("비밀번호가 일치하지 않습니다."),
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

                          if (joinEmail.isEmpty || !isValidEmail(joinEmail)) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text("유효한 이메일 주소를 입력하세요."),
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

                          if (!isAgreed) {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  content: Text("약관에 동의해야 합니다."),
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

                          joins(joinId, joinPw, joinName, joinEmail);
                        },

                        child: SizedBox(
                          width: 500,
                          height: 45,
                          child: Center(
                            child: Text(
                              "회원가입",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}