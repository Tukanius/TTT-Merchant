import 'package:ttt_merchant_flutter/models/card_models/card_balance.dart';
import 'package:ttt_merchant_flutter/models/card_models/charge_wallet.dart';
import 'package:ttt_merchant_flutter/models/card_models/check_card.dart';
import 'package:ttt_merchant_flutter/models/payment_models/pay_method.dart';
import 'package:ttt_merchant_flutter/models/purchase_models/purchase_model.dart';
import 'package:ttt_merchant_flutter/models/purchase_models/purchase_request.dart';
import 'package:ttt_merchant_flutter/models/payment_models/qpay_payment.dart';
import 'package:ttt_merchant_flutter/models/inspector_models/result.dart';
import 'package:ttt_merchant_flutter/models/sales_models/sales_model.dart';
import 'package:ttt_merchant_flutter/models/sales_models/sales_request.dart';
import 'package:ttt_merchant_flutter/models/card_models/wallet_transaction.dart';
import 'package:ttt_merchant_flutter/utils/http_request.dart';

class SalesApi extends HttpRequest {
  getCardBalanceV2(CheckCard data) async {
    var res = await post(
      '/sls/appv2/order/check-card',
      data: data.toJson(),
      handler: true,
    );
    return CardBalance.fromJson(res as Map<String, dynamic>);
  }

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
  }

  checkPayment(String id) async {
    var res = await get('/sls/app/invoices/$id/check', handler: true);

    return QpayPayment.fromJson(res as Map<String, dynamic>);
  }

  checkMoney(String id) async {
    var res = await get('/sls/app/invoices/$id/cash', handler: true);
    return res;
  }

  checkPaymentMethod(String id, PayMethod data) async {
    var res = await put(
      '/sls/app/invoices/$id/pay',
      data: data.toJson(),
      handler: true,
    );
    return QpayPayment.fromJson(res as Map<String, dynamic>);
  }

  getPayment(String id) async {
    var res = await get('/sls/app/invoices/$id', handler: true);
    return QpayPayment.fromJson(res as Map<String, dynamic>);
  }

  rechargeWallet(ChargeWallet data) async {
    var res = await post(
      '/sls/app/transaction/charge',
      data: data.toJson(),
      handler: true,
    );
    return QpayPayment.fromJson(res as Map<String, dynamic>);
  }

  getWalletHistory(ResultArguments resultArguments) async {
    var res = await get('/sls/app/transaction', data: resultArguments.toJson());
    return Result.fromJson(res, WalletTransaction.fromJson);
  }

  paySales(String id) async {
    var res = await put('/sls/app/request/$id/pay');
    return res;
  }
}
