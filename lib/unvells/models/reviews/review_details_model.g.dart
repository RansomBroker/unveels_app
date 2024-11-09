// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'review_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewDetailsModel _$ReviewDetailsModelFromJson(Map<String, dynamic> json) =>
    ReviewDetailsModel(
      json['productId'] as String?,
      (json['customerRating'] as num?)?.toDouble(),
      json['thumbNail'] as String?,
      json['productName'] as String?,
      json['dominantColor'] as String?,
      json['reviewDate'] as String?,
      json['reviewTitle'] as String?,
      json['reviewDetail'] as String?,
      (json['averageRating'] as num?)?.toDouble(),
      (json['totalProductReviews'] as num?)?.toDouble(),
      (json['ratingData'] as List<dynamic>?)
          ?.map((e) => RatingData.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$ReviewDetailsModelToJson(ReviewDetailsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'productId': instance.productId,
      'customerRating': instance.customerRating,
      'thumbNail': instance.thumbNail,
      'productName': instance.productName,
      'dominantColor': instance.dominantColor,
      'reviewDate': instance.reviewDate,
      'reviewTitle': instance.reviewTitle,
      'reviewDetail': instance.reviewDetail,
      'averageRating': instance.averageRating,
      'totalProductReviews': instance.totalProductReviews,
      'ratingData': instance.ratingData,
    };

RatingData _$RatingDataFromJson(Map<String, dynamic> json) => RatingData(
      (json['ratingValue'] as num?)?.toDouble(),
      json['ratingCode'] as String?,
    );

Map<String, dynamic> _$RatingDataToJson(RatingData instance) =>
    <String, dynamic>{
      'ratingValue': instance.ratingValue,
      'ratingCode': instance.ratingCode,
    };
