import 'package:ttt_merchant_flutter/models/card_balance.dart';
import 'package:ttt_merchant_flutter/models/charge_wallet.dart';
import 'package:ttt_merchant_flutter/models/check_card.dart';
import 'package:ttt_merchant_flutter/models/pay_method.dart';
import 'package:ttt_merchant_flutter/models/qpay_payment.dart';
import 'package:ttt_merchant_flutter/models/result.dart';
import 'package:ttt_merchant_flutter/models/wallet_transaction.dart';
import 'package:ttt_merchant_flutter/utils/http_request.dart';

class BalanceApi extends HttpRequest {
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

    return QpayPayment.fromJson(res as Map<String, dynamic>);
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
}
