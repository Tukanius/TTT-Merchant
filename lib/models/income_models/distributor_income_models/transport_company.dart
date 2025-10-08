part '../../../parts/income_models/distributor_income_models/transport_company.dart';

class TransportCompany {
  String? id;
  String? firstName;
  String? lastName;
  String? name;

  TransportCompany({this.id, this.firstName, this.lastName, this.name});
  static $fromJson(Map<String, dynamic> json) =>
      _$TransportCompanyFromJson(json);

  factory TransportCompany.fromJson(Map<String, dynamic> json) =>
      _$TransportCompanyFromJson(json);
  Map<String, dynamic> toJson() => _$TransportCompanyToJson(this);
}
