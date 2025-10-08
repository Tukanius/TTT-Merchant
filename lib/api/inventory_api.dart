// import 'package:ttt_merchant_flutter/models/income_models/distributor_income_models/dist_confirm_income.dart';
import 'package:ttt_merchant_flutter/models/income_models/distributor_income_models/dist_confirm_income.dart';
import 'package:ttt_merchant_flutter/models/income_models/distributor_income_models/income_list_model.dart';
import 'package:ttt_merchant_flutter/models/income_models/distributor_income_models/income_model.dart';
import 'package:ttt_merchant_flutter/models/result.dart';
import 'package:ttt_merchant_flutter/utils/http_request.dart';

class InventoryApi extends HttpRequest {
  // incomeConfirm(ConfirmIncomeRequest data, String id) async {
  //   var res = await put(
  //     '/inv/app/inout/$id/note',
  //     data: data.toJson(),
  //     handler: true,
  //   );
  //   return res;
  // }

  getIncomeInList(ResultArguments resultArguments) async {
    var res = await get(
      '/inv/app/inoutrequest/in',
      data: resultArguments.toJson(),
    );
    return Result.fromJson(res, IncomeListModel.fromJson);
  }

  getIncomeOutList(ResultArguments resultArguments) async {
    var res = await get(
      '/inv/app/inoutrequest/out',
      data: resultArguments.toJson(),
    );
    return Result.fromJson(res, IncomeListModel.fromJson);
  }

  getIncomeDetail(String id, String type) async {
    var res = await get('/inv/app/inoutrequest/$id/$type');
    return IncomeModel.fromJson(res as Map<String, dynamic>);
  }

  incomeConfirmNew(ConfirmIncomeRequest data, String id) async {
    var res = await put(
      '/inv/app/inoutrequest/$id/confirm',
      data: data.toJson(),
      handler: true,
    );
    return res;
  }
}
