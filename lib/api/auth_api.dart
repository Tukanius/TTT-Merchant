import 'package:ttt_merchant_flutter/utils/http_request.dart';
import '../models/user_models/user.dart';

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
}
