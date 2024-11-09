/*
 *
  

 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
part 'home_page_product.g.dart';

@JsonSerializable()
class Product {
  @JsonKey(name: "product_id")
  String? productId;
  String? thumb;
  @JsonKey(name: "dominant_color")
  String? dominantColor;
  String? name;
  String? price;
  String? quantity;
  int? special;
  @JsonKey(name: "formatted_special")
  String? formattedSpecial;
  String? tax;
  int? rating;
  String? reviews;
  bool? hasOption;
  @JsonKey(name: "wishlist_status")
  bool? wishlistStatus;

  Product(
      {this.productId,
        this.thumb,
        this.dominantColor,
        this.name,
        this.price,
        this.quantity,
        this.special,
        this.formattedSpecial,
        this.tax,
        this.rating,
        this.reviews,
        this.hasOption,
        this.wishlistStatus});

  factory Product.fromJson(Map<String, dynamic> json) =>
      _$ProductFromJson(json);
}