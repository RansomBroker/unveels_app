
/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';

import '../base_model.dart';
part 'advance_search_model.g.dart';


@JsonSerializable()
class AdvanceSearchModel extends BaseModel{
  @JsonKey(name:"fieldList")
  List<FieldList>? fieldList;
  AdvanceSearchModel({this.fieldList});

  factory AdvanceSearchModel.fromJson(Map<String, dynamic> json) => _$AdvanceSearchModelFromJson(json);

  Map<String, dynamic> toJson() => _$AdvanceSearchModelToJson(this);
}

@JsonSerializable()
class FieldList {
  @JsonKey(name: "label")
  String? label;
  @JsonKey(name: "title")
  String? title;
  @JsonKey(name: "inputType")
  String? inputType;
  @JsonKey(name: "attributeCode")
  String? attributeCode;
  @JsonKey(name: "maxQueryLength")
  String? maxQueryLength;
  @JsonKey(name: "options")
  List<Options>? options;
  dynamic value;


  FieldList({this.label, this.options, this.title, this.attributeCode, this.inputType, this.maxQueryLength, this.value});

  factory FieldList.fromJson(Map<String, dynamic> json) => _$FieldListFromJson(json);

  Map<String, dynamic> toJson() => _$FieldListToJson(this);

}

@JsonSerializable()
class Options {
  @JsonKey(name:"value")
  String? value;
  @JsonKey(name:"label")
  String? label;
  bool? isSelected = false;

  Options({this.label, this.value, this.isSelected});

  factory Options.fromJson(Map<String, dynamic> json) => _$OptionsFromJson(json);

  Map<String, dynamic> toJson() => _$OptionsToJson(this);

}