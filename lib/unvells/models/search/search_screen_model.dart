

/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';

import '../base_model.dart';
part 'search_screen_model.g.dart';


@JsonSerializable()
class SearchScreenModel extends BaseModel{
  @JsonKey(name: "suggestProductArray")
  SuggestProduct? suggestProductArray;
  SearchScreenModel({this.suggestProductArray});

  factory SearchScreenModel.fromJson(Map<String, dynamic> json) => _$SearchScreenModelFromJson(json);

  Map<String, dynamic> toJson() => _$SearchScreenModelToJson(this);
}

@JsonSerializable()
class SuggestProduct{

@JsonKey(name: "tags")
List<Tags>? tags;

@JsonKey(name: "products")
List<Product>? products;

SuggestProduct({this.products, this.tags});

factory SuggestProduct.fromJson(Map<String, dynamic> json) => _$SuggestProductFromJson(json);

Map<String, dynamic> toMap() => _$SuggestProductToJson(this);
}

@JsonSerializable()
class Tags{
  @JsonKey(name:"label")
  String? label;

  @JsonKey(name: "count")
  int? count;

  Tags({this.label, this.count});

  factory Tags.fromJson(Map<String, dynamic> json) => _$TagsFromJson(json);
  Map<String,dynamic> toJson() => _$TagsToJson(this);

}

@JsonSerializable()
class Product{
  @JsonKey(name:"price")
  String? price;
  @JsonKey(name: "thumbnail")
  String? thumbNail;
  @JsonKey(name: "productId")
  String? productId;
  @JsonKey(name: "productName")
  String? productName;
  @JsonKey(name:"specialPrice")
  String? specialPrice;
  @JsonKey(name:"hasSpecialPrice")
  bool? hasSpecialPrice;

  Product({this.thumbNail, this.productName, this.price, this.hasSpecialPrice, this.specialPrice});

  factory Product.fromJson(Map<String, dynamic> json) => _$ProductFromJson(json);

  Map<String, dynamic> toJson() => _$ProductToJson(this);
}