part '../../parts/sales_models/request_product_post.dart';

class RequestProductPost {
  String? product;
  int? totalCount;

  RequestProductPost({this.product, this.totalCount});
  static $fromJson(Map<String, dynamic> json) =>
      _$RequestProductPostFromJson(json);

  factory RequestProductPost.fromJson(Map<String, dynamic> json) =>
      _$RequestProductPostFromJson(json);
  Map<String, dynamic> toJson() => _$RequestProductPostToJson(this);
}
