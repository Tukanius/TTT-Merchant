import 'package:ttt_merchant_flutter/models/sales_models/request_product_post.dart';

part '../../parts/sales_models/sales_request.dart';

class SalesRequest {
  String? description;
  List<RequestProductPost>? requestProducts;

  SalesRequest({this.description, this.requestProducts});
  static $fromJson(Map<String, dynamic> json) => _$SalesRequestFromJson(json);

  factory SalesRequest.fromJson(Map<String, dynamic> json) =>
      _$SalesRequestFromJson(json);
  Map<String, dynamic> toJson() => _$SalesRequestToJson(this);
}
