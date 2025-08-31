part '../../parts/income_models/staff_user.dart';

class StaffUser {
  String? id;
  String? firstName;
  String? lastName;

  StaffUser({this.id, this.firstName, this.lastName});
  static $fromJson(Map<String, dynamic> json) => _$StaffUserFromJson(json);

  factory StaffUser.fromJson(Map<String, dynamic> json) =>
      _$StaffUserFromJson(json);
  Map<String, dynamic> toJson() => _$StaffUserToJson(this);
}
