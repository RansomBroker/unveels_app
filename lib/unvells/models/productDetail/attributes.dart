/*
 *
  

 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/unvells/models/productDetail/product_attributes_options.dart';
part 'attributes.g.dart';

@JsonSerializable()
class Attributes{

  String? code;
  int? id;
  String? label;
  List<ProductAttributeOption>? options;
  String? position;
  String? swatchData;
  String? swatchType;
  bool? updateProductPreviewImage;

  Attributes(this.code, this.id, this.label, this.options, this.position,
      this.swatchData, this.swatchType, this.updateProductPreviewImage);

  factory Attributes.fromJson(Map<String, dynamic> json) =>
      _$AttributesFromJson(json);

  Map<String, dynamic> toJson() => _$AttributesToJson(this);

}