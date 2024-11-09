/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/unvells/models/categoryPage/banner_images.dart';
import 'package:test_new/unvells/models/categoryPage/product_tile_data.dart';
import 'package:test_new/unvells/models/homePage/featured_categories.dart';

import 'home_page_banner.dart';
part 'website_data.g.dart';

@JsonSerializable()
class WebsiteData {
  int? id;
  String? name;
  String? baseUrl;
  bool? selected;


  WebsiteData({this.id, this.name, this.baseUrl, this.selected});


  factory WebsiteData.fromJson(Map<String, dynamic> json) =>
    _$WebsiteDataFromJson(json);


  Map<String, dynamic> toJson() => _$WebsiteDataToJson(this);
}