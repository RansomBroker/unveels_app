/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
part 'footer_menu.g.dart';

@JsonSerializable()
class FooterMenu {
  @JsonKey(name: "information_id")
  String? informationId;
  String? title;
  String? status;
  String? sortOrder;

  FooterMenu({this.informationId, this.title, this.status, this.sortOrder});

  factory FooterMenu.fromJson(Map<String, dynamic> json) =>
      _$FooterMenuFromJson(json);

  Map<String, dynamic> toJson() => _$FooterMenuToJson(this);
}