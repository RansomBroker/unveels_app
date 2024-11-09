/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/unvells/models/base_model.dart';

part 'walk_through_model.g.dart';

@JsonSerializable()
class WalkThroughModel extends BaseModel {
  @JsonKey(name: "walkthroughVersion")
  double ? walkthroughVersion;

  @JsonKey(name: "walkthroughData")
  List<WalkthroughData>? walkthroughData;


  WalkThroughModel({this.walkthroughVersion, this.walkthroughData});

  factory WalkThroughModel.fromJson(Map<String, dynamic> json) =>
      _$WalkThroughModelFromJson(json);

  Map<String, dynamic> toJson() => _$WalkThroughModelToJson(this);

}

@JsonSerializable()
class WalkthroughData {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "image")
  String? name;

  @JsonKey(name: "title")
  String? productId;

  @JsonKey(name: "content")
  @JsonKey(name: "description")
  String? content;


  WalkthroughData(this.id, this.name, this.productId, this.content);

  factory WalkthroughData.fromJson(Map<String, dynamic> json) =>
      _$WalkthroughDataFromJson(json);

  Map<String, dynamic> toJson() => _$WalkthroughDataToJson(this);
}


