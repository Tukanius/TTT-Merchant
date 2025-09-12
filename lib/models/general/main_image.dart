part '../../parts/general/main_image.dart';

class MainImage {
  String? url;

  MainImage({this.url});
  static $fromJson(Map<String, dynamic> json) => _$MainImageFromJson(json);

  factory MainImage.fromJson(Map<String, dynamic> json) =>
      _$MainImageFromJson(json);
  Map<String, dynamic> toJson() => _$MainImageToJson(this);
}
