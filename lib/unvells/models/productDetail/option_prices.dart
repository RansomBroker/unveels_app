/*
 *


 *
 * /
 */

import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/unvells/models/productDetail/price.dart';

part 'option_prices.g.dart';

@JsonSerializable()
class OptionPrices{
  Price? oldPrice;
  Price? basePrice;
  Price? finalPrice;
  Price? tierPrices;
  int? product;

  OptionPrices(this.oldPrice, this.basePrice, this.finalPrice, this.tierPrices,
      this.product);

  factory OptionPrices.fromJson(Map<String, dynamic> json) =>
      _$OptionPricesFromJson(json);

  Map<String, dynamic> toJson() => _$OptionPricesToJson(this);
}