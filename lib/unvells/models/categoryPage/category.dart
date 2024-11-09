/*
 *


 *
 * /
 */

import 'package:flutter/cupertino.dart';
import 'package:json_annotation/json_annotation.dart';

import 'banner_images.dart';
part 'category.g.dart';

@JsonSerializable()
class Category{

  int? id;
  String? name;
  String? thumbnail;
  String? thumbnailDominantColor;
  bool? hasChildren;
  List<Category>? childCategories;
  List<BannerImages>? bannerImage;

  Category(this.id, this.name, this.thumbnail, this.thumbnailDominantColor,
      this.hasChildren, this.childCategories, this.bannerImage);

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryToJson(this);
}