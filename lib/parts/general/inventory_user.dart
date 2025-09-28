part of '../../models/general/inventory_user.dart';

InventoryUser _$InventoryUserFromJson(Map<String, dynamic> json) {
  return InventoryUser(
    id: json['_id'] != null ? json['_id'] as String : null,
    userType: json['userType'] != null ? json['userType'] as String : null,
    staffUser: json['staffUser'] != null
        ? StaffUser.fromJson(json['staffUser'])
        : null,
    name: json['name'] != null ? json['name'] as String : null,
    address: json['address'] != null ? Address.fromJson(json['address']) : null,
    registerNo: json['registerNo'] != null
        ? json['registerNo'] as String
        : null,
  );
}

Map<String, dynamic> _$InventoryUserToJson(InventoryUser instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['_id'] = instance.id;
  if (instance.userType != null) json['userType'] = instance.userType;
  if (instance.staffUser != null) json['staffUser'] = instance.staffUser;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.address != null) json['address'] = instance.address;
  if (instance.registerNo != null) json['registerNo'] = instance.registerNo;

  return json;
}
