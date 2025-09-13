part '../../../parts/income_models/distributor_income_models/in_out_types.dart';

class InOutTypes {
  String? id;
  String? status;
  String? date;

  InOutTypes({this.id, this.status, this.date});
  static $fromJson(Map<String, dynamic> json) => _$InOutTypesFromJson(json);

  factory InOutTypes.fromJson(Map<String, dynamic> json) =>
      _$InOutTypesFromJson(json);
  Map<String, dynamic> toJson() => _$InOutTypesToJson(this);
}
