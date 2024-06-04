// UserController 클래스
import 'package:get/get.dart';

class UserController extends GetxController {
  var userId = ''.obs;
  var userName = ''.obs;
  var userEmail = ''.obs;

  void setUser(String id, String name, String email) {
    userId.value = id;
    userName.value = name;
    userEmail.value = email;
  }

  // 로그인 성공 시 호출되는 메서드
  void loginSuccess(String id, String name, String email) {
    setUser(id, name, email);
  }
}
