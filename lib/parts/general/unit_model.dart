part of '../../models/general/unit_model.dart';

Unit _$UnitFromJson(Map<String, dynamic> json) {
  return Unit(
    id: json['_id'] != null ? json['_id'] as String : null,
    parent: json['parent'] != null ? json['parent'] as String : null,
    name: json['name'] != null ? json['name'] as String : null,
    type: json['type'] != null ? json['type'] as String : null,
    createdAt: json['createdAt'] != null ? json['createdAt'] as String : null,
    updatedAt: json['updatedAt'] != null ? json['updatedAt'] as String : null,
  );
}

Map<String, dynamic> _$UnitToJson(Unit instance) {
  Map<String, dynamic> json = {};

  if (instance.id != null) json['_id'] = instance.id;
  if (instance.parent != null) json['parent'] = instance.parent;
  if (instance.name != null) json['name'] = instance.name;
  if (instance.type != null) json['type'] = instance.type;
  if (instance.createdAt != null) json['createdAt'] = instance.createdAt;
  if (instance.updatedAt != null) json['updatedAt'] = instance.updatedAt;

  return json;
}
