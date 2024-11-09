
/*
 *


 *
 * /
 */

import 'package:test_new/unvells/models/base_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/unvells/models/categoryPage/banner_images.dart';
import 'package:test_new/unvells/models/categoryPage/category.dart';
import 'package:test_new/unvells/models/categoryPage/product_tile_data.dart';
part 'category_page_response.g.dart';


@JsonSerializable()
class CategoryPageResponse extends BaseModel{

  List<Category>? categories;
  List<ProductTileData>? productList;
  List<ProductTileData>? hotSeller;
  List<BannerImages>? bannerImage;
  List<BannerImages>? smallBannerImage;

  CategoryPageResponse(this.categories, this.productList, this.hotSeller,
      this.bannerImage, this.smallBannerImage);

  factory CategoryPageResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryPageResponseFromJson(json);

  Map<String, dynamic> toJson() => _$CategoryPageResponseToJson(this);
}
