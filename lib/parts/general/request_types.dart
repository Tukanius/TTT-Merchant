part of '../../models/general/request_types.dart';

RequestTypes _$RequestTypesFromJson(Map<String, dynamic> json) {
  return RequestTypes(
    name: json['name'] != null ? json['name'] as String : null,
    code: json['code'] != null ? json['code'] as String : null,
  );
}

Map<String, dynamic> _$RequestTypesToJson(RequestTypes instance) {
  Map<String, dynamic> json = {};
  if (instance.name != null) json['name'] = instance.name;
  if (instance.code != null) json['code'] = instance.code;
  return json;
}
