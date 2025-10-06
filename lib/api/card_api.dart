import 'package:ttt_merchant_flutter/models/user_models/user_address.dart';
import 'package:ttt_merchant_flutter/models/user_models/user_card_request.dart';
import 'package:ttt_merchant_flutter/utils/http_request.dart';

class CardApi extends HttpRequest {
  createCardRequest(UserCardRequest data) async {
    var res = await post(
      '/crd/app/id-card/card/request/create',
      data: data.toJson(),
      handler: true,
    );
    return res;
  }

  userCardRequestCreate(UserCardRequest data) async {
    var res = await post(
      '/crd/app/id-card/card/request/create',
      data: data.toJson(),
      handler: true,
    );
    return res;
  }

  getAddress() async {
    List<dynamic> jsonData = await get('/crd/app/address');
    return jsonData.map((item) => UserAddress.fromJson(item)).toList();
  }
}
