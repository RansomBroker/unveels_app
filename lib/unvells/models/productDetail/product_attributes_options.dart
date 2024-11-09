/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/unvells/models/productDetail/swatch_data.dart';
part 'product_attributes_options.g.dart';

@JsonSerializable()
class ProductAttributeOption{
  int? id;
  String? label;
  List<String>? products;
  SwatchData? swatchData;

  ProductAttributeOption(this.id, this.label, this.products);

  factory ProductAttributeOption.fromJson(Map<String, dynamic> json) =>
      _$ProductAttributeOptionFromJson(json);

  Map<String, dynamic> toJson() => _$ProductAttributeOptionToJson(this);
}