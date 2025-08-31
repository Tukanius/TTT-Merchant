part of '../../models/sales_models/request_product_post.dart';

RequestProductPost _$RequestProductPostFromJson(Map<String, dynamic> json) {
  return RequestProductPost(
    product: json['product'] != null ? json['product'] as String : null,
    totalCount: json['totalCount'] != null ? json['totalCount'] as int : null,
  );
}

Map<String, dynamic> _$RequestProductPostToJson(RequestProductPost instance) {
  Map<String, dynamic> json = {};

  if (instance.product != null) json['product'] = instance.product;
  if (instance.totalCount != null) json['totalCount'] = instance.totalCount;

  return json;
}
