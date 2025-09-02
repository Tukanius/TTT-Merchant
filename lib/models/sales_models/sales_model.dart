import 'package:ttt_merchant_flutter/models/sales_models/distributor_model.dart';
import 'package:ttt_merchant_flutter/models/sales_models/from_inventory.dart';
import 'package:ttt_merchant_flutter/models/sales_models/request_product.dart';
import 'package:ttt_merchant_flutter/models/sales_models/to_inventory.dart';
import 'package:ttt_merchant_flutter/models/user.dart';

part '../../parts/sales_models/sales_model.dart';

class Sales {
  String? id;
  bool? isActive;
  bool? isDeleted;
  bool? isHidden;
  String? code;
  String? description;
  Distributor? distributor;
  ToInventory? toInventory;
  List<RequestProduct>? requestProduct;
  int? weight;
  String? requestType;
  List<String>? images;
  User? user;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;
  FromInventory? fromInventory;
  int? totalCount;
  String? saleType;
  String? loadDate;
  String? sendDate;
  int? totalAmount;

  Sales({
    this.id,
    this.isActive,
    this.isDeleted,
    this.isHidden,
    this.code,
    this.description,
    this.distributor,
    this.toInventory,
    this.requestProduct,
    this.weight,
    this.requestType,
    this.images,
    this.user,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
    this.fromInventory,
    this.totalCount,
    this.saleType,
    this.loadDate,
    this.sendDate,
    this.totalAmount,
  });
  static $fromJson(Map<String, dynamic> json) => _$SalesFromJson(json);

  factory Sales.fromJson(Map<String, dynamic> json) => _$SalesFromJson(json);
  Map<String, dynamic> toJson() => _$SalesToJson(this);
}
