/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/unvells/models/catalog/layered_data.dart';
import 'package:test_new/unvells/models/catalog/sorting_data.dart';

import '../base_model.dart';
import '../categoryPage/product_tile_data.dart';
import '../homePage/home_page_banner.dart';

part 'catalog_model.g.dart';

@JsonSerializable()
class CatalogModel extends BaseModel {
  @JsonKey(name: "productList")
  List<ProductTileData>? productList;

  @JsonKey(name: "totalCount")
  int? totalCount;

  @JsonKey(name: "sortingData")
  List<SortingData>? sortingData;

  @JsonKey(name: "layeredData")
  List<LayeredData>? layeredData;

  @JsonKey(name: "banners")
  List<Banners>? banners;

  @JsonKey(name: "criteriaData")
  List<String>? criteriaData;

  CatalogModel({
    this.productList,
    this.totalCount,
    this.sortingData,
    this.layeredData,
    this.banners,
    this.criteriaData,
  });

  factory CatalogModel.fromJson(Map<String, dynamic> json) =>
      _$CatalogModelFromJson(json);

  Map<String, dynamic> toJson() => _$CatalogModelToJson(this);
}
