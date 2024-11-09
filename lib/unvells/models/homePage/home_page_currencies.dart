/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';

import 'home_page_currency.dart';
part 'home_page_currencies.g.dart';

@JsonSerializable()
class AllowedCurrencies {
  @JsonKey(name: "label")
  String? label;

  @JsonKey(name: "code")
  String? code;

  AllowedCurrencies({this.label, this.code});

  factory AllowedCurrencies.fromJson(Map<String, dynamic> json) =>
      _$AllowedCurrenciesFromJson(json);


  Map<String, dynamic> toJson() => _$AllowedCurrenciesToJson(this);

}