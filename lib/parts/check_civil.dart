part of '../models/check_civil.dart';

CheckCivil _$CheckCivilFromJson(Map<String, dynamic> json) {
  return CheckCivil(
    civilId: json['civilId'] != null ? json['civilId'] as String : null,
    distributorRegnum: json['distributorRegnum'] != null
        ? json['distributorRegnum'] as String
        : null,
  );
}

Map<String, dynamic> _$CheckCivilToJson(CheckCivil instance) {
  Map<String, dynamic> json = {};

  if (instance.civilId != null) json['civilId'] = instance.civilId;
  if (instance.distributorRegnum != null)
    json['distributorRegnum'] = instance.distributorRegnum;

  return json;
}
