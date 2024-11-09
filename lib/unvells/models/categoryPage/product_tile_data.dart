/*
 *


 *
 * /
 */

import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

import '../productDetail/configurable_data.dart';
part 'product_tile_data.g.dart';

@JsonSerializable()
class ProductTileData{

  String? availability;
  String? dominantColor;
  int? entityId;
  String finalPrice;
  String? formattedFinalPrice;
  String? formattedPrice;
  String? formattedTierPrice;
  bool hasRequiredOptions=false;
  bool? isAvailable;
  bool? isInRange;
  bool? isInWishlist;
  bool? isNew;
  int? minAddToCartQty;
  String? name;
  String? price;

  int? reviewCount;
  String? thumbNail;
  String? tierPrice;
  String? typeId;
  var rating;
  int? wishlistItemId;
  bool? isChecked;

  ProductTileData(
      this.availability,
      this.dominantColor,
      this.entityId,
      this.finalPrice,
      this.formattedFinalPrice,
      this.formattedPrice,
      this.formattedTierPrice,
      this.hasRequiredOptions,
      this.isAvailable,
      this.isInRange,
      this.isInWishlist,
      this.isNew,
      this.minAddToCartQty,
      this.name,
      this.price,
      this.reviewCount,
      this.thumbNail,
      this.tierPrice,
      this.typeId,
      this.rating,
      this.wishlistItemId,
      );

  factory ProductTileData.fromJson(Map<String, dynamic> json) =>
      _$ProductTileDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductTileDataToJson(this);

  bool hasSpecialPrice(){
    return  double.parse(finalPrice) != 0.0 && double.parse(finalPrice.toString()) < double.parse(price.toString()) && (isInRange ?? true);
  }

  String getDiscountPercentage(){
    return "${(100 - double.parse(finalPrice.toString()) / double.parse(price.toString()) * 100).round()}";
  }


}