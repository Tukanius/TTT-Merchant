part of '../../../models/income_models/distributor_income_models/in_out_types.dart';

InOutTypes _$InOutTypesFromJson(Map<String, dynamic> json) {
  return InOutTypes(
    id: json['_id'] != null ? json['_id'] as String : null,
    status: json['status'] != null ? json['status'] as String : null,
    date: json['date'] != null ? json['date'] as String : null,
  );
}

Map<String, dynamic> _$InOutTypesToJson(InOutTypes instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['_id'] = instance.id;
  if (instance.status != null) json['status'] = instance.status;
  if (instance.date != null) json['date'] = instance.date;

  return json;
}
