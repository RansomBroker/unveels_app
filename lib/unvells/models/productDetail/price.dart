/*
 *


 *
 * /
 */

import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';
part 'price.g.dart';



@JsonSerializable()
class Price{
  dynamic? amount;

  Price(this.amount);

  factory Price.fromJson(Map<String, dynamic> json) =>
      _$PriceFromJson(json);

  Map<String, dynamic> toJson() => _$PriceToJson(this);
}