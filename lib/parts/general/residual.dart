part of '../../models/general/residual.dart';

Residual _$ResidualFromJson(Map<String, dynamic> json) {
  return Residual(
    id: json['_id'] != null ? json['_id'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    residual: json['residual'] != null ? json['residual'] as int : null,
    unit: json['unit'] != null ? Unit.fromJson(json['unit']) : null,
    weight: json['weight'] != null ? json['weight'] as String : null,
    mainImage: json['mainImage'] != null
        ? MainImage.fromJson(json['mainImage'])
        : null,
  );
}

Map<String, dynamic> _$ResidualToJson(Residual instance) {
  Map<String, dynamic> json = {};
  if (instance.id != null) json['_id'] = instance.id;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.residual != null) json['residual'] = instance.residual;
  if (instance.unit != null) json['unit'] = instance.unit;
  if (instance.weight != null) json['weight'] = instance.weight;
  if (instance.mainImage != null) json['mainImage'] = instance.mainImage;
  return json;
}
