/*
 *
  

 *
 * /
 */

import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

import '../base_model.dart';

part 'reviews_list_model.g.dart';

@JsonSerializable()
class ReviewsListModel extends BaseModel{

  @JsonKey(name: "reviewList")
  List<ReviewsListData>? reviewList;

  @JsonKey(name: "totalCount")
  int? totalCount;

  ReviewsListModel({this.reviewList, this.totalCount});

  factory ReviewsListModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewsListModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewsListModelToJson(this);

}

@JsonSerializable()
class ReviewsListData {
  @JsonKey(name: "id")
  String? id;

  @JsonKey(name: "productId")
  String? productId;

  @JsonKey(name: "customerRating")
  double? customerRating;

  @JsonKey(name: "thumbNail")
  String? thumbNail;

  @JsonKey(name: "productName")
  String? productName;

  @JsonKey(name: "dominantColor")
  String? dominantColor;


  ReviewsListData(this.id, this.productId, this.customerRating, this.thumbNail,
      this.productName, this.dominantColor);

  factory ReviewsListData.fromJson(Map<String, dynamic> json) =>
      _$ReviewsListDataFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewsListDataToJson(this);
}