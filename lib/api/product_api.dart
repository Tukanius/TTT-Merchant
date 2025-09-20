import 'package:ttt_merchant_flutter/models/income_models/distributor_income_models/dist_confirm_income.dart';
import 'package:ttt_merchant_flutter/models/income_models/distributor_income_models/dist_income_list.dart';
import 'package:ttt_merchant_flutter/models/income_models/distributor_income_models/dist_income_model.dart';
import 'package:ttt_merchant_flutter/models/income_models/storeman_income_models/storeman_income_list.dart';
import 'package:ttt_merchant_flutter/models/income_models/storeman_income_models/storeman_income_model.dart';
import 'package:ttt_merchant_flutter/models/purchase_models/purchase_model.dart';
import 'package:ttt_merchant_flutter/models/purchase_request.dart';
import 'package:ttt_merchant_flutter/models/qpay_payment.dart';
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
    return Result.fromJson(res, PurchaseModel.fromJson);
  }

  postPurchaseRequest(PurchaseRequest data) async {
    var res = await post(
      '/sls/app/order/purchase',
      data: data.toJson(),
      handler: true,
    );
    return QpayPayment.fromJson(res as Map<String, dynamic>);
  }

  getSaleDetailData(String id) async {
    var res = await get('/sls/app/request/$id');
    return Sales.fromJson(res as Map<String, dynamic>);
  }

  postSalesRequest(SalesRequest data) async {
    var res = await post(
      '/sls/app/request',
      data: data.toJson(),
      handler: true,
    );
    return res;
    // return CardBalance.fromJson(res as Map<String, dynamic>);
  }

  incomeConfirm(ConfirmIncomeRequest data, String id) async {
    var res = await put(
      '/inv/app/inout/$id/note',
      data: data.toJson(),
      handler: true,
    );
    return res;
  }

  getDistributorIncome(String id) async {
    var res = await get('/inv/app/inout/$id');
    return DistIncomeModel.fromJson(res as Map<String, dynamic>);
  }

  getStoremanIncome(String id) async {
    var res = await get('/inv/app/inout/$id');
    return StoremanIncomeModel.fromJson(res as Map<String, dynamic>);
  }

  getIncomeHistory(ResultArguments resultArguments) async {
    var res = await get(
      '/inv/app/inout/in-products',
      data: resultArguments.toJson(),
    );
    return Result.fromJson(res, DistIncomeList.fromJson);
  }

  getIncomeSaleMan(ResultArguments resultArguments) async {
    var res = await get('/inv/app/inout', data: resultArguments.toJson());
    return Result.fromJson(res, StoremanIncomeList.fromJson);
  }
}
