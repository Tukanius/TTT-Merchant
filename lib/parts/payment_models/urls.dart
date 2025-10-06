part of '../../models/payment_models/urls.dart';

Urls _$UrlsFromJson(Map<String, dynamic> json) {
  return Urls(
    name: json['name'] != null ? json['name'] as String : null,
    description: json['description'] != null
        ? json['description'] as String
        : null,
    logo: json['logo'] != null ? json['logo'] as String : null,
    link: json['link'] != null ? json['link'] as String : null,
  );
}

Map<String, dynamic> _$UrlsToJson(Urls instance) {
  Map<String, dynamic> json = {};

  if (instance.name != null) json['name'] = instance.name;
  if (instance.description != null) json['description'] = instance.description;
  if (instance.logo != null) json['logo'] = instance.logo;
  if (instance.link != null) json['link'] = instance.link;

  return json;
}
