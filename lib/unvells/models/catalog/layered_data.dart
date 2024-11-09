/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';

import 'layered_data_options.dart';

part 'layered_data.g.dart';

@JsonSerializable()
class LayeredData {
  @JsonKey(name: "label")
  String? label;

  @JsonKey(name: "code")
  String? code;

  @JsonKey(name: "options")
  List<LayeredDataOptions>? options;

  LayeredData({
    this.label,
    this.code,
    this.options,
  });

  factory LayeredData.fromJson(Map<String, dynamic> json) =>
      _$LayeredDataFromJson(json);

  Map<String, dynamic> toJson() => _$LayeredDataToJson(this);
}
