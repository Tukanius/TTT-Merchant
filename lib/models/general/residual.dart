import 'package:ttt_merchant_flutter/models/general/unit_model.dart';

part '../../parts/general/residual.dart';

class Residual {
  String? id;
  String? name;
  int? residual;
  Unit? unit;
  String? weight;

  Residual({this.id, this.name, this.residual, this.unit, this.weight});
  static $fromJson(Map<String, dynamic> json) => _$ResidualFromJson(json);

  factory Residual.fromJson(Map<String, dynamic> json) =>
      _$ResidualFromJson(json);
  Map<String, dynamic> toJson() => _$ResidualToJson(this);
}
