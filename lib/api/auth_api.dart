// import 'package:honog_flutter/models/country_list.dart';
// import 'package:honog_flutter/models/upload_image.dart';
// import 'package:honog_flutter/utils/http_request.dart';
import 'package:ttt_merchant_flutter/utils/http_request.dart';
import '../models/user.dart';

class AuthApi extends HttpRequest {
  login(User user) async {
    var res = await post(
      '/aut/app/auth/login',
      data: user.toJson(),
      handler: true,
    );
    return User.fromJson(res as Map<String, dynamic>);
  }

  me(bool handler) async {
    var res = await get('/aut/app/auth/me', handler: handler);
    return User.fromJson(res as Map<String, dynamic>);
  }

  logout() async {
    var res = await post('/aut/app/auth/logout', handler: false);
    return res;
  }

  // chagePassword(User user) async {
  //   var res = await post(
  //     '/aut/app/auth/change-password',
  //     data: user.toJson(),
  //     handler: true,
  //   );
  //   return User.fromJson(res as Map<String, dynamic>);
  // }

  // registerPhone(User data) async {
  //   var res = await post('/auth/register', data: data.toJson(), handler: true);
  //   return User.fromJson(res as Map<String, dynamic>);
  // }

  // forget(User data) async {
  //   var res = await post(
  //     '/aut/app/auth/forgot',
  //     data: data.toJson(),
  //     handler: true,
  //   );
  //   return User.fromJson(res as Map<String, dynamic>);
  // }

  // getOtp(String type, String method) async {
  //   var res = await get("/aut/app/otp/get?type=$type&otpMethod=$method");
  //   return User.fromJson(res as Map<String, dynamic>);
  // }

  // getOtpChangePhone(String otpMethod, String phone) async {
  //   var res = await get("/otp?otpMethod=$otpMethod&phone=$phone");
  //   return User.fromJson(res as Map<String, dynamic>);
  // }

  // onBoarding(User data) async {
  //   var res = await put("/user/profile", data: data.toJson(), handler: true);
  //   return User.fromJson(res as Map<String, dynamic>);
  // }

  // otpVerify(User data) async {
  //   Map<String, dynamic> json = {};
  //   json['otpCode'] = data.otpCode;
  //   json['otpMethod'] = data.otpMethod;
  //   var res = await post('/aut/app/otp/verify', data: json, handler: true);
  //   return User.fromJson(res as Map<String, dynamic>);
  // }

  // changePassword(User user) async {
  //   var res = await post(
  //     '/auth/change-password',
  //     data: user.toJson(),
  //     handler: true,
  //   );
  //   return User.fromJson(res as Map<String, dynamic>);
  // }

  // changeUserPassword(User user) async {
  //   var res = await post(
  //     '/auth/change-password',
  //     data: user.toJson(),
  //     handler: true,
  //   );
  //   return res;
  // }

  // upload(String path) async {
  //   String fileName = path.split('/').last;
  //   FormData formData = FormData.fromMap({
  //     'file': await MultipartFile.fromFile(path, filename: fileName),
  //   });
  //   var res = await post('/media/image/upload', data: formData);

  //   return UploadImage.fromJson(res as Map<String, dynamic>);
  // }

  // changeNames(User data) async {
  //   var res = await put("/user/name", data: data.toJson());
  //   return User.fromJson(res as Map<String, dynamic>);
  // }

  // changePhone(User data) async {
  //   var res = await put("/user/phone", data: data.toJson());
  //   return User.fromJson(res as Map<String, dynamic>);
  // }

  // changePhoneVerify(User data) async {
  //   Map<String, dynamic> json = {};
  //   json['otpCode'] = data.otpCode;
  //   var res = await post('/user/phone/verify', data: json, handler: true);
  //   return User.fromJson(res as Map<String, dynamic>);
  // }

  // changeAddress(User data) async {
  //   var res = await put('/user/address', data: data.toJson());
  //   return User.fromJson(res as Map<String, dynamic>);
  // }

  // // getCountry() async {
  // //   List<dynamic> jsonData = await get('/user/countries');
  // //   return jsonData.map((item) => CountryList.fromJson(item)).toList();
  // // }

  // changeLanguage(String language) async {
  //   var res = await get('/languages/$language');
  //   return res;
  // }

  // changeEmail(User data) async {
  //   var res = await put("/user/email", data: data.toJson());
  //   return User.fromJson(res as Map<String, dynamic>);
  // }

  // verifyEmail(User data) async {
  //   Map<String, dynamic> json = {};
  //   json['otpCode'] = data.otpCode;
  //   var res = await post('/user/email/verify', data: json, handler: true);
  //   return User.fromJson(res as Map<String, dynamic>);
  // }

  // deactivateVerify(User data) async {
  //   Map<String, dynamic> json = {};
  //   json['otpCode'] = data.otpCode;
  //   var res = await post(
  //     '/user/account/deactive/verify',
  //     data: json,
  //     handler: true,
  //   );
  //   return User.fromJson(res as Map<String, dynamic>);
  // }

  // accountDeactivate() async {
  //   var res = await post("/user/account/deactive", handler: true);
  //   return User.fromJson(res as Map<String, dynamic>);
  // }

  // accountDeactivateVerify(User data) async {
  //   Map<String, dynamic> json = {};
  //   json['otpCode'] = data.otpCode;
  //   var res = await post(
  //     '/user/account/deactive/verify',
  //     data: json,
  //     handler: true,
  //   );
  //   return User.fromJson(res as Map<String, dynamic>);
  // }

  // loginWithGoogle(User data) async {
  //   var res = await post(
  //     "/auth/login/google",
  //     data: data.toJson(),
  //     handler: true,
  //   );
  //   return User.fromJson(res as Map<String, dynamic>);
  // }

  // loginWithApple(User data) async {
  //   var res = await post(
  //     "/auth/login/apple",
  //     data: data.toJson(),
  //     handler: true,
  //   );
  //   return User.fromJson(res as Map<String, dynamic>);
  // }
}
