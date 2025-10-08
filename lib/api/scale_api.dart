import 'package:ttt_merchant_flutter/models/inspector_models/inspector_model.dart';
import 'package:ttt_merchant_flutter/models/result.dart';
import 'package:ttt_merchant_flutter/utils/http_request.dart';

class ScaleApi extends HttpRequest {
  getInspectorList(ResultArguments resultArguments) async {
    var res = await get('/scl/app/receipt', data: resultArguments.toJson());
    return Result.fromJson(res, InspectorModel.fromJson);
  }

  getInspectorItem(String id) async {
    var res = await get('/scl/app/receipt/$id');
    return InspectorModel.fromJson(res as Map<String, dynamic>);
  }

  putInspector(String id) async {
    var res = await put('/scl/app/receipt/$id/confirm', handler: true);
    return res;
  }
}
