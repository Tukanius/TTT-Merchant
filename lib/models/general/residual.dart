import 'package:ttt_merchant_flutter/models/general/main_image.dart';
import 'package:ttt_merchant_flutter/models/general/unit_model.dart';

part '../../parts/general/residual.dart';

class Residual {
  String? id;
  String? name;
  num? residual;
  Unit? unit;
  String? weight;
  MainImage? mainImage;
  num? price;

  Residual({
    this.id,
    this.name,
    this.residual,
    this.unit,
    this.weight,
    this.mainImage,
    this.price,
  });
  static $fromJson(Map<String, dynamic> json) => _$ResidualFromJson(json);

  factory Residual.fromJson(Map<String, dynamic> json) =>
      _$ResidualFromJson(json);
  Map<String, dynamic> toJson() => _$ResidualToJson(this);
}
