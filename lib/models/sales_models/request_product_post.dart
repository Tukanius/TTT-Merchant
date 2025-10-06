import 'package:ttt_merchant_flutter/models/general/main_image.dart';

part '../../parts/sales_models/request_product_post.dart';

class RequestProductPost {
  String? product;
  num? totalCount;
  String? name;
  num? price;
  num? residual;
  MainImage? mainImage;

  RequestProductPost({
    this.product,
    this.totalCount,
    this.name,
    this.price,
    this.residual,
    this.mainImage,
  });
  static $fromJson(Map<String, dynamic> json) =>
      _$RequestProductPostFromJson(json);

  factory RequestProductPost.fromJson(Map<String, dynamic> json) =>
      _$RequestProductPostFromJson(json);
  Map<String, dynamic> toJson() => _$RequestProductPostToJson(this);
}
