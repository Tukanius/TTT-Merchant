part '../parts/check_civil.dart';

class CheckCivil {
  String? civilId;
  String? distributorRegnum;
  CheckCivil({this.civilId, this.distributorRegnum});
  static $fromJson(Map<String, dynamic> json) => _$CheckCivilFromJson(json);

  factory CheckCivil.fromJson(Map<String, dynamic> json) =>
      _$CheckCivilFromJson(json);
  Map<String, dynamic> toJson() => _$CheckCivilToJson(this);
}
