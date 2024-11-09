
/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';

import '../base_model.dart';
part 'wishlist_addallcart_response_model.g.dart';


@JsonSerializable()
class WishlistAddallcartResponseModel extends BaseModel{

  @JsonKey(name: "data")
  WishlistAddAllData? data;

  WishlistAddallcartResponseModel({this.data});

  factory WishlistAddallcartResponseModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistAddallcartResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistAddallcartResponseModelToJson(this);
}

@JsonSerializable()
class WishlistAddAllData {
  @JsonKey(name: "allToCart")
  WishlistAddAllToCart? allToCart;

  WishlistAddAllData(
      {this.allToCart});

  factory WishlistAddAllData.fromJson(Map<String, dynamic> json) =>
      _$WishlistAddAllDataFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistAddAllDataToJson(this);
}


@JsonSerializable()
class WishlistAddAllToCart extends BaseModel {

  @JsonKey(name: "warning")
  String? warning;

  WishlistAddAllToCart({this.warning});

  factory WishlistAddAllToCart.fromJson(Map<String, dynamic> json) =>
      _$WishlistAddAllToCartFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistAddAllToCartToJson(this);
}
