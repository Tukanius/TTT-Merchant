part '../../parts/general/unit_model.dart';

class Unit {
  String? id;
  String? parent;
  String? name;
  String? type;
  String? createdAt;
  String? updatedAt;

  Unit({
    this.id,
    this.parent,
    this.name,
    this.type,
    this.createdAt,
    this.updatedAt,
  });
  static $fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);

  factory Unit.fromJson(Map<String, dynamic> json) => _$UnitFromJson(json);
  Map<String, dynamic> toJson() => _$UnitToJson(this);
}
