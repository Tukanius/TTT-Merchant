part of '../../models/sales_models/request_product_post.dart';

RequestProductPost _$RequestProductPostFromJson(Map<String, dynamic> json) {
  return RequestProductPost(
    product: json['product'] != null ? json['product'] as String : null,
    totalCount: json['totalCount'] != null ? json['totalCount'] as num : null,
    name: json['name'] != null ? json['name'] as String : null,
    price: json['price'] != null ? json['price'] as num : null,
    residual: json['residual'] != null ? json['residual'] as num : null,
    mainImage: json['mainImage'] != null
        ? MainImage.fromJson(json['mainImage'])
        : null,
  );
}

Map<String, dynamic> _$RequestProductPostToJson(RequestProductPost instance) {
  Map<String, dynamic> json = {};

  if (instance.product != null) json['product'] = instance.product;
  if (instance.totalCount != null) json['totalCount'] = instance.totalCount;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.price != null) json['price'] = instance.price;
  if (instance.residual != null) json['residual'] = instance.residual;
  if (instance.mainImage != null) json['mainImage'] = instance.mainImage;
  return json;
}
