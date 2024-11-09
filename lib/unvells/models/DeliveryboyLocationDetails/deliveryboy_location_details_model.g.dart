// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'deliveryboy_location_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

DeliveryBoyLocationDetailsModel _$DeliveryBoyLocationDetailsModelFromJson(
        Map<String, dynamic> json) =>
    DeliveryBoyLocationDetailsModel(
      latitude: json['latitude'] as String?,
      longitude: json['longitude'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?;

Map<String, dynamic> _$DeliveryBoyLocationDetailsModelToJson(
        DeliveryBoyLocationDetailsModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
