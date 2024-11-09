// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reviews_list_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ReviewsListModel _$ReviewsListModelFromJson(Map<String, dynamic> json) =>
    ReviewsListModel(
      reviewList: (json['reviewList'] as List<dynamic>?)
          ?.map((e) => ReviewsListData.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalCount: (json['totalCount'] as num?)?.toInt(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$ReviewsListModelToJson(ReviewsListModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'reviewList': instance.reviewList,
      'totalCount': instance.totalCount,
    };

ReviewsListData _$ReviewsListDataFromJson(Map<String, dynamic> json) =>
    ReviewsListData(
      json['id'] as String?,
      json['productId'] as String?,
      (json['customerRating'] as num?)?.toDouble(),
      json['thumbNail'] as String?,
      json['productName'] as String?,
      json['dominantColor'] as String?,
    );

Map<String, dynamic> _$ReviewsListDataToJson(ReviewsListData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'productId': instance.productId,
      'customerRating': instance.customerRating,
      'thumbNail': instance.thumbNail,
      'productName': instance.productName,
      'dominantColor': instance.dominantColor,
    };
