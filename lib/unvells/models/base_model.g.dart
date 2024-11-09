// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseModel _$BaseModelFromJson(Map<String, dynamic> json) => BaseModel(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      otherError: json['otherError'] as String?,
      redirect: json['redirect'] as String?,
      cartCount: (json['cartCount'] as num?)?.toInt(),
      transferValidation: json['transferValidation'] as bool?,
    )..eTag = json['eTag'] as String?;

Map<String, dynamic> _$BaseModelToJson(BaseModel instance) => <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
    };
