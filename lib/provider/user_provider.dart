import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ttt_merchant_flutter/api/auth_api.dart';
import 'package:ttt_merchant_flutter/models/user.dart';

class UserProvider extends ChangeNotifier {
  User user = User();
  // String deviceToken = '';
  String myAccessToken = '';

  // String googleFirstName = "";
  // String googleLastName = "";
  // String authType = "";
  // bool isHaveEmail = false;
  // String changedPhone = '';

  login(User data) async {
    user = await AuthApi().login(data);
    setAccessToken(user.accessToken);
    myAccessToken == '' ? myAccessToken = user.accessToken! : '';
    notifyListeners();
  }

  // loginWithGoogle(User data) async {
  //   user = await AuthApi().loginWithGoogle(data);
  //   setAccessToken(user.accessToken);
  //   myAccessToken == '' ? myAccessToken = user.accessToken! : '';
  //   notifyListeners();
  // }

  // loginWithApple(User data) async {
  //   user = await AuthApi().loginWithApple(data);
  //   setAccessToken(user.accessToken);
  //   myAccessToken == '' ? myAccessToken = user.accessToken! : '';
  //   notifyListeners();
  // }
  // setPassword(User data) async {
  //   user = await AuthApi().chagePassword(data);
  //   await setAccessToken(user.accessToken);
  //   return user;
  // }

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

  // // setUsername(String email) async {
  // //   SharedPreferences prefs = await SharedPreferences.getInstance();
  // //   prefs.setString("EMAIL", email);
  // // }

  // registerPhone(User data) async {
  //   user = await AuthApi().registerPhone(data);
  //   setAccessToken(user.accessToken);
  //   notifyListeners();
  // }

  // getOtp(String type, String method) async {
  //   var res = await AuthApi().getOtp(type, method);
  //   await setAccessToken(user.accessToken);
  //   notifyListeners();
  //   return res;
  // }

  // getOtpChangePhone(String otpMethod, String phone) async {
  //   var res = await AuthApi().getOtpChangePhone(otpMethod, phone);
  //   await setAccessToken(user.accessToken);
  //   notifyListeners();
  //   return res;
  // }

  // otpVerify(User data) async {
  //   user = await AuthApi().otpVerify(data);
  //   setAccessToken(user.accessToken);
  //   notifyListeners();
  // }

  // changePassword(User data) async {
  //   user = await AuthApi().changePassword(data);
  //   await setAccessToken(user.accessToken);
  //   myAccessToken == '' ? myAccessToken = user.accessToken! : '';
  //   notifyListeners();
  // }

  // forgetPassword(User data) async {
  //   user = await AuthApi().forget(data);
  //   await setAccessToken(user.accessToken);
  //   return user;
  // }

  // onBoarding(User data) async {
  //   user = await AuthApi().onBoarding(data);
  //   setAccessToken(user.tokenType);
  //   myAccessToken == '' ? myAccessToken = user.accessToken! : '';
  //   notifyListeners();
  // }

  auth() async {
    String? token = await getAccessToken();
    if (token != null) {
      await clearAccessToken();
    }
  }

  // void setGoogleUserName(String displayName, String type) {
  //   List<String> nameParts = displayName.split(" ");
  //   googleFirstName = nameParts.isNotEmpty ? nameParts[0] : "";
  //   googleLastName = nameParts.length > 1 ? nameParts.sublist(1).join(" ") : "";
  //   authType = type;
  //   notifyListeners();
  // }

  // void setAppleUserName(String firstName, String lastName, String type) {
  //   googleFirstName = firstName;
  //   googleLastName = firstName;
  //   authType = type;
  //   notifyListeners();
  // }

  // void setIsHaveEmail(bool isHaveEmailApple) {
  //   isHaveEmail = isHaveEmailApple;
  //   notifyListeners();
  // }
}
