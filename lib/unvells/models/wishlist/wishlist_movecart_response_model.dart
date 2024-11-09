
/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';

import '../base_model.dart';
part 'wishlist_movecart_response_model.g.dart';


@JsonSerializable()
class WishlistMovecartResponseModel extends BaseModel{

  @JsonKey(name: "data")
  WishlistAddAllData? data;

  WishlistMovecartResponseModel({this.data});

  factory WishlistMovecartResponseModel.fromJson(Map<String, dynamic> json) =>
      _$WishlistMovecartResponseModelFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistMovecartResponseModelToJson(this);
}

@JsonSerializable()
class WishlistAddAllData {
  @JsonKey(name: "wishlistToCart")
  WishlistToCart? wishlistToCart;

  WishlistAddAllData(
      {this.wishlistToCart});

  factory WishlistAddAllData.fromJson(Map<String, dynamic> json) =>
      _$WishlistAddAllDataFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistAddAllDataToJson(this);
}


@JsonSerializable()
class WishlistToCart extends BaseModel {

  WishlistToCart();

  factory WishlistToCart.fromJson(Map<String, dynamic> json) =>
      _$WishlistToCartFromJson(json);

  Map<String, dynamic> toJson() => _$WishlistToCartToJson(this);
}
