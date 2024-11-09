// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_screen_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpScreenModel _$SignUpScreenModelFromJson(Map<String, dynamic> json) =>
    SignUpScreenModel(
      isPrefixVisible: json['isPrefixVisible'] as bool?,
      isPrefixRequired: json['isPrefixRequired'] as bool?,
      prefixOptions: (json['prefixOptions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      prefixHasOptions: json['prefixHasOptions'] as bool?,
      isMiddlenameVisible: json['isMiddlenameVisible'] as bool?,
      isSuffixVisible: json['isSuffixVisible'] as bool?,
      isSuffixRequired: json['isSuffixRequired'] as bool?,
      suffixOptions: (json['suffixOptions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      suffixHasOptions: json['suffixHasOptions'] as bool?,
      isMobileVisible: json['isMobileVisible'] as bool?,
      isMobileRequired: json['isMobileRequired'] as bool?,
      isDOBVisible: json['isDOBVisible'] as bool?,
      isDOBRequired: json['isDOBRequired'] as bool?,
      isTaxRequired: json['isTaxRequired'] as bool?,
      isTaxVisible: json['isTaxVisible'] as bool?,
      isGenderRequired: json['isGenderRequired'] as bool?,
      isGenderVisible: json['isGenderVisible'] as bool?,
      dateFormat: json['dateFormat'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?
      ..isMiddlenameRequired = json['isMiddlenameRequired'] as bool?
      ..prefix = json['prefix'] as String?
      ..suffix = json['suffix'] as String?
      ..gender = json['gender'] as String?;

Map<String, dynamic> _$SignUpScreenModelToJson(SignUpScreenModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'isPrefixVisible': instance.isPrefixVisible,
      'isPrefixRequired': instance.isPrefixRequired,
      'prefixOptions': instance.prefixOptions,
      'prefixHasOptions': instance.prefixHasOptions,
      'isMiddlenameVisible': instance.isMiddlenameVisible,
      'isMiddlenameRequired': instance.isMiddlenameRequired,
      'isSuffixVisible': instance.isSuffixVisible,
      'isSuffixRequired': instance.isSuffixRequired,
      'suffixOptions': instance.suffixOptions,
      'suffixHasOptions': instance.suffixHasOptions,
      'isMobileVisible': instance.isMobileVisible,
      'isMobileRequired': instance.isMobileRequired,
      'isDOBVisible': instance.isDOBVisible,
      'isDOBRequired': instance.isDOBRequired,
      'isTaxRequired': instance.isTaxRequired,
      'isTaxVisible': instance.isTaxVisible,
      'isGenderRequired': instance.isGenderRequired,
      'isGenderVisible': instance.isGenderVisible,
      'dateFormat': instance.dateFormat,
      'prefix': instance.prefix,
      'suffix': instance.suffix,
      'gender': instance.gender,
    };
