part of '../../models/sales_models/distributor_model.dart';

Distributor _$DistributorFromJson(Map<String, dynamic> json) {
  return Distributor(
    id: json['_id'] != null ? json['_id'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    email: json['email'] != null ? json['email'] as String : null,
    phone: json['phone'] != null ? json['phone'] as String : null,
    registerNo: json['registerNo'] != null
        ? json['registerNo'] as String
        : null,
    isActive: json['isActive'] != null ? json['isActive'] as bool : null,
    latitude: json['latitude'] != null ? json['latitude'] as double : null,
    longitude: json['longitude'] != null ? json['longitude'] as double : null,
    staffUser: json['staffUser'] != null ? json['staffUser'] as String : null,
    deletedAt: json['deletedAt'] != null ? json['deletedAt'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
  );
}

Map<String, dynamic> _$DistributorToJson(Distributor instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['_id'] = instance.id;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.email != null) json['email'] = instance.email;
  if (instance.phone != null) json['phone'] = instance.phone;
  if (instance.registerNo != null) json['registerNo'] = instance.registerNo;
  if (instance.isActive != null) json['isActive'] = instance.isActive;
  if (instance.latitude != null) json['latitude'] = instance.latitude;
  if (instance.longitude != null) json['longitude'] = instance.longitude;
  if (instance.staffUser != null) json['staffUser'] = instance.staffUser;
  if (instance.deletedAt != null) json['deletedAt'] = instance.deletedAt;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;

  return json;
}
