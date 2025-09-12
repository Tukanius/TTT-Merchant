part of '../../models/general/main_image.dart';

MainImage _$MainImageFromJson(Map<String, dynamic> json) {
  return MainImage(url: json['url'] != null ? json['url'] as String : null);
}

Map<String, dynamic> _$MainImageToJson(MainImage instance) {
  Map<String, dynamic> json = {};

  if (instance.url != null) json['url'] = instance.url;

  return json;
}
