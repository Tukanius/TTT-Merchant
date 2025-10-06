import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttt_merchant_flutter/api/auth_api.dart';
import 'package:ttt_merchant_flutter/models/user_models/user.dart';

class UserProvider extends ChangeNotifier {
  User user = User();
  String myAccessToken = '';

  login(User data) async {
    user = await AuthApi().login(data);
    setAccessToken(user.accessToken);
    myAccessToken == '' ? myAccessToken = user.accessToken! : '';
    notifyListeners();
  }

  me(bool handler) async {
    user = await AuthApi().me(handler);
    notifyListeners();
  }

  setAccessToken(String? token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token != null) prefs.setString("ACCESS_TOKEN", token);
  }

  logout() async {
    await AuthApi().logout();
    notifyListeners();
    clearAccessToken();
  }

  clearAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove("ACCESS_TOKEN");
  }

  static Future<String?> getAccessToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("ACCESS_TOKEN");
    return token;
  }

  static Future<String?> getDeviceToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString("DEVICE_TOKEN");
    return token;
  }

  setDeviceToken(String? token) async {
    print('success');
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (token != null) prefs.setString("DEVICE_TOKEN", token);
  }

  auth() async {
    String? token = await getAccessToken();
    if (token != null) {
      await clearAccessToken();
    }
  }
}
