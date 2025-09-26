part '../../parts/sales_models/distributor_model.dart';

class Distributor {
  String? id;
  String? name;
  String? email;
  String? phone;
  String? registerNo;
  bool? isActive;
  String? staffUser;
  String? deletedAt;
  String? createdAt;
  String? updatedAt;

  Distributor({
    this.id,
    this.name,
    this.email,
    this.phone,
    this.registerNo,
    this.isActive,
    this.staffUser,
    this.deletedAt,
    this.createdAt,
    this.updatedAt,
  });
  static $fromJson(Map<String, dynamic> json) => _$DistributorFromJson(json);

  factory Distributor.fromJson(Map<String, dynamic> json) =>
      _$DistributorFromJson(json);
  Map<String, dynamic> toJson() => _$DistributorToJson(this);
}
