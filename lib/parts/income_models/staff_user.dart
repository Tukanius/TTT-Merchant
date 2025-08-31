part of '../../models/income_models/staff_user.dart';

StaffUser _$StaffUserFromJson(Map<String, dynamic> json) {
  return StaffUser(
    id: json['_id'] != null ? json['_id'] as String : null,
    firstName: json['firstName'] != null ? json['firstName'] as String : null,
    lastName: json['lastName'] != null ? json['lastName'] as String : null,
  );
}

Map<String, dynamic> _$StaffUserToJson(StaffUser instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['_id'] = instance.id;
  if (instance.firstName != null) json['firstName'] = instance.firstName;
  if (instance.lastName != null) json['lastName'] = instance.lastName;

  return json;
}
