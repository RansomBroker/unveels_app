// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'account_info_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccountInfoModel _$AccountInfoModelFromJson(Map<String, dynamic> json) =>
    AccountInfoModel(
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      email: json['email'] as String?,
      telephone: json['telephone'] as String?,
      fax: json['fax'] as String?,
      status: (json['status'] as num?)?.toInt(),
      customField: json['customField'] as List<dynamic>?,
      bannerImage: json['bannerImage'] as String?,
      profileImage: json['profileImage'] as String?,
      prefixOptions: (json['prefixOptions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      suffixOptions: (json['suffixOptions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      middleName: json['middleName'] as String?,
      isPrefixVisible: json['isPrefixVisible'] as bool?,
      isPrefixRequired: json['isPrefixRequired'] as bool?,
      prefixValue: json['prefixValue'] as String?,
      prefixHasOptions: json['prefixHasOptions'] as bool?,
      isMiddlenameVisible: json['isMiddlenameVisible'] as bool?,
      isSuffixVisible: json['isSuffixVisible'] as bool?,
      isSuffixRequired: json['isSuffixRequired'] as bool?,
      suffixValue: json['suffixValue'] as String?,
      suffixHasOptions: json['suffixHasOptions'] as bool?,
      isMobileVisible: json['isMobileVisible'] as bool?,
      isMobileRequired: json['isMobileRequired'] as bool?,
      isDOBVisible: json['isDOBVisible'] as bool?,
      isDOBRequired: json['isDOBRequired'] as bool?,
      DOBValue: json['DOBValue'] as String?,
      isTaxVisible: json['isTaxVisible'] as bool?,
      isTaxRequired: json['isTaxRequired'] as bool?,
      taxValue: json['taxValue'] as String?,
      isGenderVisible: json['isGenderVisible'] as bool?,
      isGenderRequired: json['isGenderRequired'] as bool?,
      genderValue: json['genderValue'] as String?,
      isFaxVisible: json['isFaxVisible'] as bool?,
      isFaxRequired: json['isFaxRequired'] as bool?,
      isTelephoneVisible: json['isTelephoneVisible'] as bool?,
      isTelephoneRequired: json['isTelephoneRequired'] as bool?,
      dateFormat: json['dateFormat'] as String?,
      url: json['url'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..transferValidation = json['transferValidation'] as bool?
      ..prefix = json['prefix'] as String?
      ..suffix = json['suffix'] as String?
      ..gender = json['gender'] as String?;

Map<String, dynamic> _$AccountInfoModelToJson(AccountInfoModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'transferValidation': instance.transferValidation,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'telephone': instance.telephone,
      'fax': instance.fax,
      'status': instance.status,
      'customField': instance.customField,
      'prefixOptions': instance.prefixOptions,
      'suffixOptions': instance.suffixOptions,
      'bannerImage': instance.bannerImage,
      'profileImage': instance.profileImage,
      'middleName': instance.middleName,
      'isPrefixVisible': instance.isPrefixVisible,
      'isPrefixRequired': instance.isPrefixRequired,
      'prefixValue': instance.prefixValue,
      'prefixHasOptions': instance.prefixHasOptions,
      'isMiddlenameVisible': instance.isMiddlenameVisible,
      'isSuffixVisible': instance.isSuffixVisible,
      'isSuffixRequired': instance.isSuffixRequired,
      'suffixValue': instance.suffixValue,
      'suffixHasOptions': instance.suffixHasOptions,
      'isMobileVisible': instance.isMobileVisible,
      'isMobileRequired': instance.isMobileRequired,
      'isDOBVisible': instance.isDOBVisible,
      'isDOBRequired': instance.isDOBRequired,
      'DOBValue': instance.DOBValue,
      'isTaxVisible': instance.isTaxVisible,
      'isTaxRequired': instance.isTaxRequired,
      'taxValue': instance.taxValue,
      'isGenderVisible': instance.isGenderVisible,
      'isGenderRequired': instance.isGenderRequired,
      'genderValue': instance.genderValue,
      'isFaxVisible': instance.isFaxVisible,
      'isFaxRequired': instance.isFaxRequired,
      'isTelephoneVisible': instance.isTelephoneVisible,
      'isTelephoneRequired': instance.isTelephoneRequired,
      'dateFormat': instance.dateFormat,
      'url': instance.url,
      'prefix': instance.prefix,
      'suffix': instance.suffix,
      'gender': instance.gender,
    };
