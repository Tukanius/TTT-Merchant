part of '../../models/sales_models/sales_request.dart';

SalesRequest _$SalesRequestFromJson(Map<String, dynamic> json) {
  return SalesRequest(
    description: json['description'] != null
        ? json['description'] as String
        : null,
    requestProducts: json['requestProducts'] != null
        ? (json['requestProducts'] as List)
              .map((e) => RequestProductPost.fromJson(e))
              .toList()
        : null,
  );
}

Map<String, dynamic> _$SalesRequestToJson(SalesRequest instance) {
  Map<String, dynamic> json = {};

  if (instance.description != null) json['description'] = instance.description;
  if (instance.requestProducts != null)
    json['requestProducts'] = instance.requestProducts;

  return json;
}
