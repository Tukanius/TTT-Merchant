import 'package:ttt_merchant_flutter/models/card_balance.dart';
import 'package:ttt_merchant_flutter/models/charge_wallet.dart';
import 'package:ttt_merchant_flutter/models/check_card.dart';
import 'package:ttt_merchant_flutter/models/income_models/confirm_income.dart';
import 'package:ttt_merchant_flutter/models/income_models/income_model.dart';
import 'package:ttt_merchant_flutter/models/pay_method.dart';
import 'package:ttt_merchant_flutter/models/purchase/purchase_model.dart';
import 'package:ttt_merchant_flutter/models/purchase_request.dart';
import 'package:ttt_merchant_flutter/models/qpay_payment.dart';
import 'package:ttt_merchant_flutter/models/result.dart';
import 'package:ttt_merchant_flutter/models/sales_models/sales_model.dart';
import 'package:ttt_merchant_flutter/models/sales_models/sales_request.dart';
import 'package:ttt_merchant_flutter/models/wallet_transaction.dart';
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

  getIncomeSaleMan(ResultArguments resultArguments) async {
    var res = await get('/inv/app/inout', data: resultArguments.toJson());
    return Result.fromJson(res, Income.fromJson);
  }

  postPurchaseRequest(PurchaseRequest data) async {
    var res = await post(
      '/sls/app/order/purchase',
      data: data.toJson(),
      handler: true,
    );
    return QpayPayment.fromJson(res as Map<String, dynamic>);
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

  getCardBalance(CheckCard data) async {
    var res = await post(
      '/sls/app/order/check-card',
      data: data.toJson(),
      handler: true,
    );
    return CardBalance.fromJson(res as Map<String, dynamic>);
  }

  checkPayment(String id) async {
    var res = await get('/sls/app/invoices/$id/check', handler: true);
    return res;
    // return CardBalance.fromJson(res as Map<String, dynamic>);
  }

  checkMoney(String id) async {
    var res = await get('/sls/app/invoices/$id/cash', handler: true);
    return res;
    // return CardBalance.fromJson(res as Map<String, dynamic>);
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
    // return Result.fromJson(res, Purchase.fromJson);
  }

  // putConfirmIncome(ConfirmIncome data) async {
  //   var res = await put('', data: data.toJson(), handler: true);
  //   return res;
  // }
}
