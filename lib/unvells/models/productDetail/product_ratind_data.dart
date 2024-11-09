/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
part 'product_ratind_data.g.dart';

@JsonSerializable()
class ProductRatingData{

  String? label;
  String? value;

  ProductRatingData(this.label, this.value);

  factory ProductRatingData.fromJson(Map<String, dynamic> json) =>
      _$ProductRatingDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductRatingDataToJson(this);
}