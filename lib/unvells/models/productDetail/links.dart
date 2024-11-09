/*
 *


 *
 * /
 */

import 'dart:ffi';
import 'package:json_annotation/json_annotation.dart';

import 'link_data.dart';
part 'links.g.dart';

@JsonSerializable()
class Links{
  String? title;
  bool? linksPurchasedSeparately;
  List<LinkData>? linkData;

  Links(this.title, this.linksPurchasedSeparately, this.linkData);

  factory Links.fromJson(Map<String, dynamic> json) =>
      _$LinksFromJson(json);

  Map<String, dynamic> toJson() => _$LinksToJson(this);
}