/*
 *
  

 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/unvells/models/order_details/order_detail_model.dart';

import '../base_model.dart';

part 'cart_item.g.dart';

@JsonSerializable()
class CartItem {
  @JsonKey(name: "thresholdQty")
  String? thresholdQty;

  @JsonKey(name: "remainingQty")
  double? remainingQty;

  @JsonKey(name: "image")
  String? image;

  @JsonKey(name: "thumbnail")
  String? thumbnail;

  @JsonKey(name: "dominantColor")
  String? dominantColor;

  @JsonKey(name: "name")
  String? name;

  @JsonKey(name: "productName")
  String? productName;

  @JsonKey(name: "sku")
  String? sku;

  @JsonKey(name: "price")
  var price;

  @JsonKey(name: "originalPrice")
  String? originalPrice;

  @JsonKey(name: "finalPrice")
  double? finalPrice;

  @JsonKey(name: "formattedPrice")
  String? formattedPrice;

  @JsonKey(name: "formattedFinalPrice")
  String? formattedFinalPrice;

  @JsonKey(name: "isInRange")
  bool? isInRange;

  @JsonKey(name: "qty")
  int? qty;

  @JsonKey(name: "productId")
  String? productId;

  @JsonKey(name: "groupedProductId")
  int? groupedProductId;

  @JsonKey(name: "typeId")
  String? typeId;

  @JsonKey(name: "subTotal")
  String? subTotal;

  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "options")
  List<OptionsItems>? options;

  @JsonKey(name: "option")
  List<OptionsItems>? option;

  @JsonKey(name: "messages")
  List<Messages>? messages;

  @JsonKey(name: "canMoveToWishlist")
  bool? canMoveToWishlist;

  bool? cartItemQtyChanged = false;


  CartItem(
  {this.thresholdQty,
    this.remainingQty,
    this.image,
    this.dominantColor,
    this.name,
    this.sku,
    this.price,
    this.finalPrice,
    this.formattedPrice,
    this.formattedFinalPrice,
    this.isInRange,
    this.qty,
    this.productId,
    this.groupedProductId,
    this.typeId,
    this.subTotal,
    this.id,
    this.options,
    this.messages,
    this.canMoveToWishlist,
    this.cartItemQtyChanged});

  factory CartItem.fromJson(Map<String, dynamic> json) =>
      _$CartItemFromJson(json);

  Map<String, dynamic> toJson() => _$CartItemToJson(this);
}

@JsonSerializable()
class OptionsItems {
  @JsonKey(name:"label")
  String? label;

  @JsonKey(name:"value")
  List<String>? value;

  @JsonKey(name:"valueIds")
  List<String>? valueIds;

  OptionsItems({this.label, this.value, this.valueIds});

  factory OptionsItems.fromJson(Map<String, dynamic> json) =>
      _$OptionsItemsFromJson(json);

  Map<String, dynamic> toJson() => _$OptionsItemsToJson(this);
}

@JsonSerializable()
class Messages {
  @JsonKey(name:"text")
  String? text;

  @JsonKey(name:"type")
  String? type;


  Messages({this.text, this.type});

  factory Messages.fromJson(Map<String, dynamic> json) =>
      _$MessagesFromJson(json);

  Map<String, dynamic> toJson() => _$MessagesToJson(this);
}
