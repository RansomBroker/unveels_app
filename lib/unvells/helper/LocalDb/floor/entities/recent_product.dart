/*
 *


 *
 * /
 */

import 'package:floor/floor.dart';

@entity
class RecentProduct{
  @primaryKey
  int? entityId;
  String? availability;
  String? dominantColor;
  String? finalPrice;
  String? formattedFinalPrice;
  String? formattedPrice;
  String? formattedTierPrice;
  bool? hasRequiredOptions=false;
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
  String ? rating;
  int? wishlistItemId;
  String? storeId;
  String? currency;


  RecentProduct({
    this.entityId,
    this.availability,
    this.dominantColor,
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
    this.storeId,
    this.currency,
  });

  @override
  String toString() {
    return ""
        "$entityId\n"
        "$availability\n"
        "$dominantColor\n"
        "$finalPrice\n"
        "$formattedFinalPrice\n"
        "$formattedPrice\n"
        "$formattedTierPrice\n"
        "$hasRequiredOptions\n"
        "$isAvailable\n"
        "$isInRange\n"
        "$isInWishlist\n"
        "$isNew\n"
        "$minAddToCartQty\n"
        "$name\n"
        "$price\n"
        "$reviewCount\n"
        "$thumbNail\n"
        "$tierPrice\n"
        "$typeId\n"
        "$rating\n"
        "$wishlistItemId\n"
        "$storeId\n"
        "$currency\n";
  }
}