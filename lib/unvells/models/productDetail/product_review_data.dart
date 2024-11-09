/*
 *


 *
 * /
 */

import 'package:json_annotation/json_annotation.dart';
import 'package:test_new/unvells/models/productDetail/product_ratind_data.dart';
part 'product_review_data.g.dart';

@JsonSerializable()
class ProductReviewData{
  String? title;
  String? details;
  List<ProductRatingData>? ratings;
  String? reviewBy;
  String? reviewOn;

  ProductReviewData(
      this.title, this.details, this.ratings, this.reviewBy, this.reviewOn);

  factory ProductReviewData.fromJson(Map<String, dynamic> json) =>
      _$ProductReviewDataFromJson(json);

  Map<String, dynamic> toJson() => _$ProductReviewDataToJson(this);
  
  

}