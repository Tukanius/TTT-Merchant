part of '../../../models/income_models/distributor_income_models/transport_company.dart';

TransportCompany _$TransportCompanyFromJson(Map<String, dynamic> json) {
  return TransportCompany(
    id: json['_id'] != null ? json['_id'] as String : null,
    firstName: json['firstName'] != null ? json['firstName'] as String : null,
    lastName: json['lastName'] != null ? json['lastName'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
  );
}

Map<String, dynamic> _$TransportCompanyToJson(TransportCompany instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['_id'] = instance.id;
  if (instance.firstName != null) json['firstName'] = instance.firstName;
  if (instance.lastName != null) json['lastName'] = instance.lastName;
  if (instance.name != null) json['name'] = instance.name;

  return json;
}
