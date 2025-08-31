import 'package:ttt_merchant_flutter/models/general/general_init.dart';
import 'package:ttt_merchant_flutter/utils/http_request.dart';

class GeneralApi extends HttpRequest {
  getInit() async {
    var res = await get("/inv/app/general/init", handler: true);
    return GeneralInit.fromJson(res as Map<String, dynamic>);
  }

  // getQr(String id) async {
  //   var res = await get("/user/$id/qrcode", handler: true);
  //   return UserQr.fromJson(res as Map<String, dynamic>);
  // }

  // getHistory(ResultArguments resultArguments) async {
  //   var res =
  //       await get('/user/eco-bin/histories', data: resultArguments.toJson());
  //   return Result.fromJson(res, InitBin.fromJson);
  // }

  // getNotify(ResultArguments resultArguments) async {
  //   var res = await get('/user/eco-bin/notifications',
  //       data: resultArguments.toJson());
  //   return Result.fromJson(res, TrashNotification.fromJson);
  // }

  // getNotifyItem(String id) async {
  //   var res = await get(
  //     '/user/eco-bin/notifications/${id}',
  //   );
  //   return TrashNotification.fromJson(res as Map<String, dynamic>);
  // }
}
