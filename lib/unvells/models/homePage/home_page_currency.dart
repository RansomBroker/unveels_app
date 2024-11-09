/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
part 'home_page_currency.g.dart';

@JsonSerializable()
class Currency {
  String? title;
  String? code;

  Currency({this.title, this.code});

  factory Currency.fromJson(Map<String, dynamic> json) =>
      _$CurrencyFromJson(json);

  Map<String, dynamic> toJson() => _$CurrencyToJson(this);
}