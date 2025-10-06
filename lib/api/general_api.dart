import 'package:ttt_merchant_flutter/models/general/general_balance.dart';
import 'package:ttt_merchant_flutter/models/general/general_init.dart';
import 'package:ttt_merchant_flutter/utils/http_request.dart';

class GeneralApi extends HttpRequest {
  getInit() async {
    var res = await get("/inv/app/general/init", handler: true);
    return GeneralInit.fromJson(res as Map<String, dynamic>);
  }

  getBalance() async {
    var res = await get('/sls/app/general/init', handler: true);
    return GeneralBalance.fromJson(res as Map<String, dynamic>);
  }
}
