import 'package:shared_preferences/shared_preferences.dart';

class AppSharedPref {
  static late SharedPreferences _instance;

  final String isloginKey = "login";

  Future<void> setIsLogin(bool islogin) async {
    _instance = await SharedPreferences.getInstance();
    print("setIsLogin $islogin");
    _instance.setBool(isloginKey, islogin);
  }

  Future<bool> getIsLogin() async {
    _instance = await SharedPreferences.getInstance();
    return _instance.getBool(isloginKey) ?? false;
  }

  Future<void> clear() async {
    _instance = await SharedPreferences.getInstance();
    _instance.clear();
  }
}
