/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';

part 'price_details.g.dart';

@JsonSerializable()
class PriceDetails {
  @JsonKey(name:"title")
  String? title;

  @JsonKey(name:"value")
  String? value;


  PriceDetails({this.title, this.value});

  factory PriceDetails.fromJson(Map<String, dynamic> json) =>
      _$PriceDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$PriceDetailsToJson(this);
}
