import 'package:ttt_merchant_flutter/models/income_models/income_model.dart';
import 'package:ttt_merchant_flutter/models/purchase/purchase_model.dart';
import 'package:ttt_merchant_flutter/models/purchase_request.dart';
import 'package:ttt_merchant_flutter/models/result.dart';
import 'package:ttt_merchant_flutter/models/sales_models/sales_model.dart';
import 'package:ttt_merchant_flutter/models/sales_models/sales_request.dart';
import 'package:ttt_merchant_flutter/utils/http_request.dart';

class ProductApi extends HttpRequest {
  getSalesHistory(ResultArguments resultArguments) async {
    var res = await get('/sls/app/request', data: resultArguments.toJson());
    return Result.fromJson(res, Sales.fromJson);
  }

  getPurchaseHistory(ResultArguments resultArguments) async {
    var res = await get('/sls/app/order', data: resultArguments.toJson());
    return Result.fromJson(res, Purchase.fromJson);
  }

  getIncomeHistory(ResultArguments resultArguments) async {
    var res = await get(
      '/inv/app/inout/in-products',
      data: resultArguments.toJson(),
    );
    return Result.fromJson(res, Income.fromJson);
  }

  postPurchaseRequest(PurchaseRequest data) async {
    var res = await post(
      '/sls/app/order/purchase',
      data: data.toJson(),
      handler: true,
    );
    return res;
  }

  postSalesRequest(SalesRequest data) async {
    var res = await post(
      '/sls/app/request',
      data: data.toJson(),
      handler: true,
    );
    return res;
  }

  // putConfirmIncome(ConfirmIncome data) async {
  //   var res = await put('', data: data.toJson(), handler: true);
  //   return res;
  // }
}
