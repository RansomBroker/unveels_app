/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/unvells/models/cart/cart_item.dart';
import 'package:test_new/unvells/models/cart/price_details.dart';
import 'package:test_new/unvells/models/categoryPage/product_tile_data.dart';

import '../base_model.dart';

part 'cart_details_model.g.dart';

@JsonSerializable()
class CartDetailsModel extends BaseModel{
  @JsonKey(name: "items")
  List<CartItem>? items;

  @JsonKey(name: "couponCode")
  String? couponCode;

  @JsonKey(name: "showThreshold")
  bool? showThreshold;

  @JsonKey(name: "isVirtual")
  bool? isVirtual;

  @JsonKey(name: "isAllowedGuestCheckout")
  bool? isAllowedGuestCheckout;

  @JsonKey(name: "totalsData")
  List<PriceDetails>? totalsData;

  @JsonKey(name: "crossSellList")
  List<ProductTileData>? crossSellList;

  @JsonKey(name: "canGuestCheckoutDownloadable")
  bool? canGuestCheckoutDownloadable;

  @JsonKey(name: "allowMultipleShipping")
  bool? allowMultipleShipping;

  @JsonKey(name: "isCheckoutAllowed")
  bool? isCheckoutAllowed;

  @JsonKey(name: "minimumAmount")
  double? minimumAmount;

  @JsonKey(name: "minimumFormattedAmount")
  String? minimumFormattedAmount;

  @JsonKey(name: "descriptionMessage")
  String? descriptionMessage;

  @JsonKey(name: "cartTotal")
  String? cartTotal;

  bool? containsDownloadableProducts = false;


  CartDetailsModel(
      {this.items,
      this.couponCode,
      this.showThreshold,
      this.isVirtual,
      this.isAllowedGuestCheckout,
      this.totalsData,
      this.crossSellList,
      this.canGuestCheckoutDownloadable,
      this.allowMultipleShipping,
      this.isCheckoutAllowed,
      this.minimumAmount,
      this.minimumFormattedAmount,
      this.descriptionMessage,
      this.cartTotal,
      this.containsDownloadableProducts});

  factory CartDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$CartDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$CartDetailsModelToJson(this);
}