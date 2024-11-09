/*
 *


 *
 * /
 */

import 'dart:ffi';
import 'package:json_annotation/json_annotation.dart';

part 'grouped_data.g.dart';
@JsonSerializable()
class GroupedData{

  String? name;
  String? id;
  bool? isAvailable;
  bool? isInRange;
  String? specialPrice;
  int? defaultQty;
  String? foramtedPrice;
  String? thumbNail;

  GroupedData(this.name, this.id, this.isAvailable, this.isInRange,
      this.specialPrice, this.defaultQty, this.foramtedPrice, this.thumbNail);

  factory GroupedData.fromJson(Map<String, dynamic> json) =>
      _$GroupedDataFromJson(json);

  Map<String, dynamic> toJson() => _$GroupedDataToJson(this);
}