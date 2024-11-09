// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rating_form_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatingFormDataModel _$RatingFormDataModelFromJson(Map<String, dynamic> json) =>
    RatingFormDataModel(
      (json['ratingFormData'] as List<dynamic>?)
          ?.map((e) => RatingFormData.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$RatingFormDataModelToJson(
        RatingFormDataModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'ratingFormData': instance.ratingFormData,
    };
