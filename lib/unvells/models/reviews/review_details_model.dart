/*
 *


 *
 * /
 */

import 'dart:ffi';

import 'package:json_annotation/json_annotation.dart';

import '../base_model.dart';

part 'review_details_model.g.dart';

@JsonSerializable()
class ReviewDetailsModel extends BaseModel{

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

  @JsonKey(name: "reviewDate")
  String? reviewDate;

  @JsonKey(name: "reviewTitle")
  String? reviewTitle;

  @JsonKey(name: "reviewDetail")
  String? reviewDetail;

  @JsonKey(name: "averageRating")
  double? averageRating;

  @JsonKey(name: "totalProductReviews")
  double? totalProductReviews;

  @JsonKey(name: "ratingData")
  List<RatingData>? ratingData;


  ReviewDetailsModel(
      this.productId,
      this.customerRating,
      this.thumbNail,
      this.productName,
      this.dominantColor,
      this.reviewDate,
      this.reviewTitle,
      this.reviewDetail,
      this.averageRating,
      this.totalProductReviews,
      this.ratingData);

  factory ReviewDetailsModel.fromJson(Map<String, dynamic> json) =>
      _$ReviewDetailsModelFromJson(json);

  Map<String, dynamic> toJson() => _$ReviewDetailsModelToJson(this);

}

@JsonSerializable()
class RatingData {

  @JsonKey(name: "ratingValue")
  double? ratingValue;

  @JsonKey(name: "ratingCode")
  String? ratingCode;


  RatingData(this.ratingValue, this.ratingCode);

  factory RatingData.fromJson(Map<String, dynamic> json) =>
      _$RatingDataFromJson(json);

  Map<String, dynamic> toJson() => _$RatingDataToJson(this);
}