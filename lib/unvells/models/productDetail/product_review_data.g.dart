// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_review_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductReviewData _$ProductReviewDataFromJson(Map<String, dynamic> json) =>
    ProductReviewData(
      json['title'] as String?,
      json['details'] as String?,
      (json['ratings'] as List<dynamic>?)
          ?.map((e) => ProductRatingData.fromJson(e as Map<String, dynamic>))
          .toList(),
      json['reviewBy'] as String?,
      json['reviewOn'] as String?,
    );

Map<String, dynamic> _$ProductReviewDataToJson(ProductReviewData instance) =>
    <String, dynamic>{
      'title': instance.title,
      'details': instance.details,
      'ratings': instance.ratings,
      'reviewBy': instance.reviewBy,
      'reviewOn': instance.reviewOn,
    };
