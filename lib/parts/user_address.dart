part of '../models/user_address.dart';

UserAddress _$UserAddressFromJson(Map<String, dynamic> json) {
  return UserAddress(
    id: json['_id'] != null ? json['_id'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    parent: json['parent'] != null ? json['parent'] as String : null,
    level: json['level'] != null ? json['level'] as int : null,
  );
}

Map<String, dynamic> _$UserAddressToJson(UserAddress instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.parent != null) json['parent'] = instance.parent;
  if (instance.level != null) json['level'] = instance.level;

  return json;
}
