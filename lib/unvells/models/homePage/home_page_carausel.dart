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
part 'home_page_carausel.g.dart';

@JsonSerializable()
class Carousel {
  String? id;
  String? category_id;
  String? type;
  String? label;
  String? color;
  String? image;
  String? image_size;

  String? block_title;
  String? block_description;
  List<ProductTileData>? productList;
  List<Banners>? banners;
  List<FeaturedCategories>? featuredCategories;


  Carousel({this.id, this.type, this.label, this.color, this.image,
      this.productList, this.banners, this.featuredCategories,this.category_id});

  factory Carousel.fromJson(Map<String, dynamic> json) =>
    _$CarouselFromJson(json);


  Map<String, dynamic> toJson() => _$CarouselToJson(this);
}