/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';

import 'home_page_currency.dart';
part 'price_format.g.dart';

@JsonSerializable()
class PriceFormat {
  @JsonKey(name: "pattern")
  String? pattern;

  int? precision;
  int? requiredPrecision;
  int? groupLength;

  @JsonKey(name: "decimalSymbol")
  String? decimalSymbol;

  @JsonKey(name: "groupSymbol")
  String? groupSymbol;

  @JsonKey(name: "integerRequired")
  bool? integerRequired;


  PriceFormat(
      {this.pattern,
      this.precision,
      this.requiredPrecision,
      this.groupLength,
      this.decimalSymbol,
      this.groupSymbol,
      this.integerRequired});

  factory PriceFormat.fromJson(Map<String, dynamic> json) =>
      _$PriceFormatFromJson(json);


  Map<String, dynamic> toJson() => _$PriceFormatToJson(this);

}