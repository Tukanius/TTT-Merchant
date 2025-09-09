import 'package:ttt_merchant_flutter/models/general/inventory_user.dart';
import 'package:ttt_merchant_flutter/models/general/product_types.dart';
import 'package:ttt_merchant_flutter/models/general/request_types.dart';
import 'package:ttt_merchant_flutter/models/general/residual.dart';

part '../../parts/general/general_init.dart';

class GeneralInit {
  List<ProductTypes>? productTypes;
  List<Residual>? residual;
  List<RequestTypes>? requestTypes;
  InventoryUser? inventory;

  GeneralInit({
    this.productTypes,
    this.residual,
    this.requestTypes,
    this.inventory,
  });
  static $fromJson(Map<String, dynamic> json) => _$GeneralInitFromJson(json);

  factory GeneralInit.fromJson(Map<String, dynamic> json) =>
      _$GeneralInitFromJson(json);
  Map<String, dynamic> toJson() => _$GeneralInitToJson(this);
}
