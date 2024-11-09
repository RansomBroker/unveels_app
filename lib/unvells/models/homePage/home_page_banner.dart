/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
part 'home_page_banner.g.dart';

@JsonSerializable()
class Banners {
  String? title;

  @JsonKey(name:"bannerType")
  String? type;

  String? link;

  @JsonKey(name:"url")
  String? url;

  @JsonKey(name:"bannerImage")
  String? bannerImage;

  @JsonKey(name: "dominant_color")
  String? dominantColor;
  int? id;
  String? name;
  String? route;

  Banners({this.title, this.type, this.link, this.url, this.bannerImage, this.dominantColor,this.id,this.name});

  factory Banners.fromJson(Map<String, dynamic> json) =>
      _$BannersFromJson(json);

  Map<String, dynamic> toJson() => _$BannersToJson(this);

}