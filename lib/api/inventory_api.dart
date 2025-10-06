import 'package:ttt_merchant_flutter/models/income_models/distributor_income_models/dist_confirm_income.dart';
import 'package:ttt_merchant_flutter/models/income_models/distributor_income_models/dist_income_list.dart';
import 'package:ttt_merchant_flutter/models/income_models/distributor_income_models/dist_income_model.dart';
import 'package:ttt_merchant_flutter/models/income_models/storeman_income_models/storeman_income_list.dart';
import 'package:ttt_merchant_flutter/models/income_models/storeman_income_models/storeman_income_model.dart';
import 'package:ttt_merchant_flutter/models/inspector_models/result.dart';
import 'package:ttt_merchant_flutter/utils/http_request.dart';

class InventoryApi extends HttpRequest {
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
