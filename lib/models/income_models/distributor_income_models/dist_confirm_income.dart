import 'package:ttt_merchant_flutter/models/purchase_models/product_purchase_model.dart';

part '../../../parts/income_models/distributor_income_models/dist_confirm_income.dart';

class ConfirmIncomeRequest {
  String? code;
  String? note;
  List<String>? images;
  bool? isComplaint;
  List<ProductPurchaseModel>? receivedProducts;
  String? complaintNote;

  ConfirmIncomeRequest({
    this.code,
    this.note,
    this.images,
    this.isComplaint,
    this.receivedProducts,
    this.complaintNote,
  });
  static $fromJson(Map<String, dynamic> json) =>
      _$ConfirmIncomeRequestFromJson(json);

  factory ConfirmIncomeRequest.fromJson(Map<String, dynamic> json) =>
      _$ConfirmIncomeRequestFromJson(json);
  Map<String, dynamic> toJson() => _$ConfirmIncomeRequestToJson(this);
}
