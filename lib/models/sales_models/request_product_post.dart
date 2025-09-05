part '../../parts/sales_models/request_product_post.dart';

class RequestProductPost {
  String? product;
  int? totalCount;
  String? name;
  int? price;
  int? residual;

  RequestProductPost({
    this.product,
    this.totalCount,
    this.name,
    this.price,
    this.residual,
  });
  static $fromJson(Map<String, dynamic> json) =>
      _$RequestProductPostFromJson(json);

  factory RequestProductPost.fromJson(Map<String, dynamic> json) =>
      _$RequestProductPostFromJson(json);
  Map<String, dynamic> toJson() => _$RequestProductPostToJson(this);
}
