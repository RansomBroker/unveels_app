/*
 *


 *
 * /
 */

import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

import 'option_value.dart';
part 'bundle_option.g.dart';

@JsonSerializable()
class BundleOption{

  @JsonKey(name:"option_id")
  String? optionId;

  @JsonKey(name:"parent_id")
  String? parentId;

  String? required;
  String? position;
  String? type;

  @JsonKey(name:"default_title")
  String? defaultTitle;

  String? title;

  String? selectedQty;
  String? selectedOption;

  List<OptionValue>? optionValues;

  BundleOption(this.optionId, this.parentId, this.required, this.position,
      this.type, this.defaultTitle, this.title, this.optionValues, this.selectedQty, this.selectedOption);

  factory BundleOption.fromJson(Map<String, dynamic> json) =>
      _$BundleOptionFromJson(json);

  Map<String, dynamic> toJson() => _$BundleOptionToJson(this);


}