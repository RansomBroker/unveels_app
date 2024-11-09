/*
 *


 *
 * /
 */

import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/unvells/models/productDetail/price.dart';
part 'prices.g.dart';



@JsonSerializable()
class Prices{
  Price? oldPrice;
  Price? basePrice;
  Price? finalPrice;

  Prices(this.oldPrice, this.basePrice, this.finalPrice);

  factory Prices.fromJson(Map<String, dynamic> json) =>
      _$PricesFromJson(json);

  Map<String, dynamic> toJson() => _$PricesToJson(this);
}